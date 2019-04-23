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
    }
    

    /*
    // MARK: - Navigation
    */

}
