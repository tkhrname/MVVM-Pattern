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
        self.viewModel.stateDidUpdate = {[weak self] state in
            switch state {
            case .loading:
                break
            case .finish:
                break
            case .error(let error):
                break
            }
        }
    }
    
    @objc func refreshControlValueDidChanged(sender: UIRefreshControl) {
        // リフレッシュ処理
    }
    /*
    // MARK: - Navigation
    */

}

// MARK: - UITableViewDataSource
extension TimeLineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension TimeLineViewController: UITableViewDelegate {
    
}
