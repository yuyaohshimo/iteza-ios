//
//  IssueCheckModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/11.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class IssueCheckModel: BaseConnectionModel {
    
    // リクエストキー
    let ReqAmount = "amount"                    // 金額
    // レスポンスキー
    let ResCheckAccountIssueId = "id"            // ID
    let ResCheckUserId = "user_id"               // ユーザID
    let ResCheckUserName = "user_name"           // ユーザ名
    let ResCheckPhoneNumber = "phone_number"     // 電話番号
    let ResCheckAccountId = "account_id"         // アカウントID
    let ResCheckBalance = "balance"              // 残高
    let ResCheckId = "checkid"                  //  小切手ID
    
    // 初期処理
    override init() {
        super.init()
        self.requestMethod = .POST
    }

     // 送信処理
    override func startConnection(parameter: Dictionary<String, AnyObject>, handler: (response: Dictionary<String, AnyObject>,httpResponse:NSHTTPURLResponse?, error: NSError?) -> Void) {
        
        if SessionSingletonData.sharedInstance.userId != nil {
            self.urlString = self.urlBaseString + "/" + SessionSingletonData.sharedInstance.accountId! + "/issue"
        }
        
        // 親クラスのメソッドで送信
        super.startConnection(parameter, handler: handler)

    }
}
