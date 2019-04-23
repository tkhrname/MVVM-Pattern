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
        
        self.iconView = UIImageView()
        self.iconView.clipsToBounds = true
        self.contentView.addSubview(self.iconView)
        
        self.nickNameLabel = UILabel()
        self.nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(self.nickNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconView.frame = CGRect(x: 15, y: 15, width: 45, height: 45)
        self.iconView.layer.cornerRadius = self.iconView.frame.size.width / 2
        self.nickNameLabel.frame = CGRect(x: self.iconView.frame.maxX + 15, y: self.iconView.frame.origin.y, width: self.contentView.frame.width - self.iconView.frame.width - 15 * 2, height: 15)
    }
    
    func setNickName(nickName: String) {
        self.nickNameLabel.text = nickName
    }
    
    func setIcon(icon: UIImage) {
        self.iconView.image = icon
    }
}
