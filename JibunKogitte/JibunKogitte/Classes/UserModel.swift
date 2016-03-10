//
//  UserModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class UserModel: BaseModel {
    // レスポンスキー
    let ResUserUserId = "user_id"               // ユーザID
    let ResUserUserName = "user_name"           // ユーザ名
    let ResUserPhoneNumber = "phone_number"     // 電話番号
    let ResUserAccountId = "account_id"         // アカウントID
    let ResUserBalance = "balance"              // 残高
    
    
    // 初期処理
    override init() {
        super.init()
        self.urlString = self.urlBaseString + "/api/cheky/user?"
        self.requestMethod = .GET
    }
}
