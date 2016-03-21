//
//  LoginModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/21.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

// ログイン
class LoginModel: BaseConnectionModel {
    
    // リクエストパラメータ(キー)
    static let ReqLoginEmailAddress = "email"                // メールアドレス
    static let ReqLoginPassword = "password"                 // パスワード
    
    // レスポンスキー
    static let ResLoginAccountId = "account_id"              // アカウント
    
    
    // 初期処理
    override init() {
        super.init()
        self.urlString = self.urlBaseString + "/auth/login"
        self.contentType = "application/json"
        self.requestMethod = .POST
    }
    
}
