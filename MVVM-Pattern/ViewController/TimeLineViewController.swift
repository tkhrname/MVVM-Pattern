//
//  TimeLineViewController.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/04/23.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit
import SafariServices

// UserListViewModelから通知を受け取りtableviewを更新する
// UserListViewModelが保持するUserCellViewModelから通知を受け取り画像を更新する、
// Cellタップで遷移する
final class TimeLineViewController: UIViewController {
    
    fileprivate var viewModel: UserListViewModel!
    fileprivate var tableView: UITableView!
    fileprivate var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table生成
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TimeLineCell.self, forCellReuseIdentifier: "TimeLineCell")
        self.view.addSubview(self.tableView)
        
        // UIRefreshControl生成
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refreshControlValueDidChanged(sender:)), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        // UserListViewModel生成
        self.viewModel = UserListViewModel()
        self.viewModel.stateDidUpdate = { [weak self] state in
            switch state {
            case .loading:
                // 通信中の処理
                self?.tableView.isUserInteractionEnabled = false
            case .finish:
                // 通信完了
                self?.tableView.isUserInteractionEnabled = true
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            case .error(let error):
                self?.tableView.isUserInteractionEnabled = true
                self?.refreshControl.endRefreshing()
                let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        // ユーザー一覧を取得
        self.viewModel.getUsers()
    }
    
    @objc func refreshControlValueDidChanged(sender: UIRefreshControl) {
        // リフレッシュ処理
        self.viewModel.getUsers()
    }

}

// MARK: - UITableViewDataSource
extension TimeLineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let timeLineCell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell") as? TimeLineCell {
            // UserCellViewModelを取得
            let cellViewModel = self.viewModel.cellViewModels[indexPath.row]
            // NickName設定
            timeLineCell.setNickName(nickName: cellViewModel.nickName)
            // icon設定
            cellViewModel.downloadImage() { progress in
                switch progress {
                case .loading(let image):
                    timeLineCell.setIcon(icon: image)
                case .finish(let image):
                    timeLineCell.setIcon(icon: image)
                case .error:
                    break
                }
            }
            return timeLineCell
        }
        fatalError()
    }
    
}

// MARK: - UITableViewDelegate
extension TimeLineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        // 遷移する
        let cellViewModel = self.viewModel.cellViewModels[indexPath.row]
        let webURL = cellViewModel.webURL
        let webViewController = SFSafariViewController(url: webURL)
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
}
