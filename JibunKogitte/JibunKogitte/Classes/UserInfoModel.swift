//
//  UserInfoModel.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class UserInfoModel: BaseModel {
    // 初期処理
    override init() {
        super.init()
        self.urlString = " /api/user_info"
        self.requestMethod = .GET
    }
}
