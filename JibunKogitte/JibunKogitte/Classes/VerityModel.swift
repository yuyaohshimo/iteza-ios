//
//  VerityModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/21.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

// ユーザの2段階認証
class VerityModel: BaseConnectionModel {
    
    // リクエストパラメータ(キー)
    static let ReqVerifyAccountId = "account_id"             // メールアドレス
    static let ReqVerifyToken = "token"                      // token
    
    // レスポンスキー
    static let ResVerifyAuthToken = "auth_token"            // Authtoken
    
    
    // 初期処理
    override init() {
        super.init()
        self.urlString = self.urlBaseString + "/auth/verity"
        self.contentType = "application/json"
        self.requestMethod = .POST
    }

}
