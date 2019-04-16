//
//  ImageDownloder.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/04/16.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation
import UIKit

final class ImageDownloder {
    // UIImageをキャッシュするための変数
    var cacheImage: UIImage?
    
    func downloadImage(imageUrl: String, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) {
        // キャッシュされたUIImageがあればそれをclosureで返す
        if let cacheImage = cacheImage {
            success(cacheImage)
        }
        
        guard let url = URL(string: imageUrl) else {
            failure(APIError.unknown)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // ErrorがあったらErrorをclosureで返す。
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            DispatchQueue.main.async {
                success(imageFromData)
            }
            self.cacheImage = imageFromData
        }
        
        
        task.resume()
    }
}
