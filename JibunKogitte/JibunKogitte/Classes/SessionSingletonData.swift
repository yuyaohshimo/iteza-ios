//
//  SessionSingletonData.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/11.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class SessionSingletonData: NSObject {
    
    // MARK: - 初期化メソッド
    class var sharedInstance:SessionSingletonData {
        struct Static {
            static let instance:SessionSingletonData = SessionSingletonData()
        }
        return Static.instance
    }
    
    // 保存対象のパラメータ
    var userId:String?          // ユーザID
    var userName:String?       // ユーザ名
    var phoneNumber:String?    // 電話番号
    var accountId:String?      // アカウント
    var balance:Int?            // 残高
    var amount = -1;           // 小切手の入力値

}
