//
//  IssueCheckModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/11.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

// 小切手発行
class IssueCheckModel: BaseConnectionModel {
    
    // リクエストキー
    static let ReqAmount = "amount"                    // 金額
    // レスポンスキー
    static let ResCheckAccountIssueId = "id"            // ID
    static let ResCheckUserId = "user_id"               // ユーザID
    static let ResCheckUserName = "user_name"           // ユーザ名
    static let ResCheckPhoneNumber = "phone_number"     // 電話番号
    static let ResCheckAccountId = "account_id"         // アカウントID
    static let ResCheckBalance = "balance"              // 残高
    static let ResCheckId = "checkid"                  //  小切手ID
    
    // 初期処理
    override init() {
        super.init()
        self.requestMethod = .POST
    }

     // 送信処理
    override func startConnection(parameter: Dictionary<String, AnyObject>, handler: (response: Dictionary<String, AnyObject>,httpResponse:NSHTTPURLResponse?, error: NSError?) -> Void) {
        
        if SessionSingletonData.sharedInstance.userId != nil {
            self.urlString = self.urlBaseString + "/checky/" + SessionSingletonData.sharedInstance.accountId! + "/issue"
        }
        
        // 親クラスのメソッドで送信
        super.startConnection(parameter, handler: handler)

    }
}
