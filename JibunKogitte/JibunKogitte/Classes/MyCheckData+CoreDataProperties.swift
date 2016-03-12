//
//  MyCheckData+CoreDataProperties.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MyCheckData {

    @NSManaged var profileImage: NSData?
    @NSManaged var maskImage:NSData?
    @NSManaged var signImage:NSData?

}
