//
//  UserCellViewModel.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/04/16.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation
import UIKit

// 通信状態
enum ImageDownloadProgress {
    case loading(UIImage) // ダウンロード中
    case finish(UIImage) // 終了
    case error // エラー
}

// Cell1つ1つに対するアウトプットを担当する
final class UserCellViewModel {
    // ユーザー
    private var user: User
    
    private let imageDownloader = ImageDownloder()
    
    // ダウンロードステータス
    private var isLoading = false
    
    // Cellに反映させるアウトプット
    var nickName: String {
        return user.name
    }
    
    // Cellを選択したときに必要なURL
    var webURL: URL {
        return URL(string: user.webURL)!
    }
    
    init(user: User) {
        self.user = user
    }
    
    func downloadImage(progress: @escaping (ImageDownloadProgress) -> Void) {
        if self.isLoading {
            return
        }
        self.isLoading = true
        // 仮のUIImageを作成
        let loadingImage = UIImage(color: .gray, size: CGSize(width: 45, height: 45))!
        // loadingをClosureで返す
        progress(.loading(loadingImage))
        
        // 画像をダウンロード
        imageDownloader.downloadImage(imageUrl: user.iconUrl, success: { image in
            progress(.finish(image))
            self.isLoading = false
        }, failure: { error in
            progress(.error)
            self.isLoading = false
        })
    }
    
}
