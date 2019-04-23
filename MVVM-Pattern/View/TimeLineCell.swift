//
//  UserListCellTableViewCell.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/04/23.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell {
    
    private var iconView: UIImageView!
    
    private var nickNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
}
