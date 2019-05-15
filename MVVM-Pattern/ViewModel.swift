//
//  ViewModel.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/04/28.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation

final class ViewModel {
    
    let changeText = Notification.Name("changeText")
    
    private let notificationCenter: NotificationCenter
    private let model: ModelProtocol
    
    init(notificationCenter: NotificationCenter, model: ModelProtocol = Model()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }
    
    
    
}

protocol ModelProtocol {
    
}

final class Model: ModelProtocol {
    
}
