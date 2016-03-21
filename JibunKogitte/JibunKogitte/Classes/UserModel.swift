//
//  UserModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class UserModel: BaseConnectionModel {
    
    // レスポンスキー
    static let ResUserUserId = "user_id"               // ユーザID
    static let ResUserUserName = "user_name"           // ユーザ名
    static let ResUserPhoneNumber = "phone_number"     // 電話番号
    static let ResUserAccountId = "account_id"         // アカウントID
    static let ResUserBalance = "balance"              // 残高
    
    
    // 初期処理
    override init() {
        super.init()
        self.urlString = self.urlBaseString + "/checky"
        self.requestMethod = .GET
    }
}
