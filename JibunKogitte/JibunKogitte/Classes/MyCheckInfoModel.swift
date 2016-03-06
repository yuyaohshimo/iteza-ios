//
//  myCheckInfoModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import Foundation

class MyCheckInfoModel: BaseModel {
    
    // 初期処理
    override init() {
        super.init()
        self.urlString = "/api/check/my"
        self.requestMethod = .GET
    }
    
}