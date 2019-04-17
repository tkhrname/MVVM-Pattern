//
//  UserListViewModel.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/04/16.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation
import UIKit

// 通信状態
enum ViewModelState {
    case loading
    case finish
    case error(Error)
}

final class UserListViewModel {
    // ViewModelStateをclosureとしてpropertyで保持
    // この変数がViewControllerに対して通知を送る役割を果たす
    var stateDidUpdate: ((ViewModelState) -> Void)?
    //userの配列
    private var users = [User]()
    // UserCellViewModelの配列
    var cellViewModels = [UserCellViewModel]()
    // Model層で定義したAPIクラスを変数として保持
    let api = API()
    // Userの配列を取得する
    func getUsers() {
        self.stateDidUpdate?(.loading)
        self.users.removeAll()
        
        api.getUsers(success: { (users) in
            self.users.append(contentsOf: users)
            for user in users {
                // UserCellViewModelの配列を作成
                
                // 成功
                self.stateDidUpdate?(.finish)
            }
        }, failure: { (error) in
            // 失敗
            self.stateDidUpdate?(.error(error))
        })
    }
    
    func usersCount() -> Int {
        return self.users.count
    }
}
