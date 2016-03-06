//
//  CommontProcess.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit
import Security

class CommonProcess {
    
    class func keychainSave(key: String, data: NSData) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ]
        SecItemDelete(query as CFDictionaryRef)
        let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
        return status == noErr
    }
    class func keychainLoad(key: String) -> NSData? {
        let keyChainQuery = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ]
        
        var retrievedData: NSData?
        var extractedData: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &extractedData)
        
        if (status == errSecSuccess) {
            retrievedData = extractedData as? NSData
        }
        return retrievedData
    }
    class func delete(key: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key ]
        let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
        return status == noErr
    }
    class func clear() -> Bool {
        let query = [ kSecClass as String : kSecClassGenericPassword ]
        let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
        return status == noErr
    }

    
}