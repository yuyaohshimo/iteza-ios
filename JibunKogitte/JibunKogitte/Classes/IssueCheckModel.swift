//
//  IssueCheckModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/11.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class IssueCheckModel: BaseConnectionModel {
    
    // 初期処理
    override init() {
        super.init()
        self.requestMethod = .POST
    }

     // 送信処理
    override func startConnection(parameter: Dictionary<String, String>, handler: (response: Dictionary<String, AnyObject>, error: NSError?) -> Void) {
        
        if SessionSingletonData.sharedInstance.userId != nil {
            self.urlString = self.urlBaseString + SessionSingletonData.sharedInstance.userId!
        }
        
        // 親クラスのメソッドで送信
        super.startConnection(parameter, handler: handler)

    }
}
