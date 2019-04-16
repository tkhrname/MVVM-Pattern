//
//  User.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/27.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation

final class User {
    let id: Int
    let name: String
    let iconUrl: String
    let webURL: String
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as! Int
        self.name = attributes["login"] as! String
        self.iconUrl = attributes["avatar_url"] as! String
        self.webURL = attributes["html_url"] as! String
    }
}
