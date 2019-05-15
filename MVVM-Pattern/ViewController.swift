//
//  ViewController.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/27.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!
    
    private let notificationCenter = NotificationCenter()
    private lazy var viewModel = ViewModel(notificationCenter: notificationCenter)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idTextField.addTarget(self,
                                   action: #selector(textFieldEditingChanged),
                                   for: .editingChanged)
        
        self.notificationCenter.addObserver(self,
                                            selector: #selector(updateValidationText),
                                            name: viewModel.changeText,
                                            object: nil)
    }


}

extension ViewController {
    @objc func textFieldEditingChanged(sender: UITextField) {
        
    }
    
    @objc func updateValidationText(notification: Notification) {
        
    }
    
    @objc func updateValidationColor(notification: Notification) {
        
    }
}
