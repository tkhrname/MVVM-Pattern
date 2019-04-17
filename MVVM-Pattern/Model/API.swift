//
//  API.swift
//  MVVM-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/27.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case unknown
    case invalidURL
    case invalidResponse
    
    var description: String {
        get {
            switch self {
            case .unknown:
                return "不明なエラーです"
            case .invalidURL:
                return "無効なURLです"
            case .invalidResponse:
                return "フォーマットが無効なレスポンスを受け取りました"
            }
        }
    }
}

class API {
    
    /// リクエストを送る
    /// 受け取ったJsonからUserの配列を作成してClosureで返す
    /// ErrorがあったらErrorをClosureで返す
    func getUsers(success: @escaping ([User]) -> Void, failure: @escaping (Error) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/users") else {
            failure(APIError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
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
            
            guard let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []), let json = jsonOptional as? [[String: Any]] else {
                DispatchQueue.main.async {
                    failure(APIError.invalidResponse)
                }
                return
            }
            
            var users = [User]()
            for j in json {
                let user = User(attributes: j)
                users.append(user)
            }
            
            DispatchQueue.main.async {
                success(users)
            }
            
        }
        
        task.resume()
    }
}
