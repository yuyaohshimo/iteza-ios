//
//  BaseModel.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import Foundation

class BaseModel:NSObject,NSURLSessionDelegate {
    
    // POSTかGETか
    enum Method :Int {
        case POST
        case GET
    }
    
    let urlBaseString = "http://www.fiftyriver.net:3000/api/checky"
    var urlString:String?           // URL
    var requestMethod:Method?       // POST or GET
    
    // MARK: - 初期処理
    override init() {
        urlString = ""
        requestMethod = .GET
    }
    
    // MARK: - データ送信処理
    func startConnection (parameter:Dictionary<String,String>,handler:(response:Dictionary<String,AnyObject>,error:NSError?)->Void) -> Void {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        var request:NSMutableURLRequest?
        
        // パラメータを付加する
        var postString:String = ""
        for (key,value) in parameter {
            postString = postString + ("\(key) = \(value)")
        }
        // POSTの場合とそれ以外の場合で処理わけ
        if (requestMethod == .POST) {
            request = NSMutableURLRequest(URL: NSURL(string: urlString!)!)
            request!.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            request!.HTTPMethod = "POST"
        } else {
            request = NSMutableURLRequest(URL: NSURL(string: urlString! + postString)!)
        }
        let access_token = NSString(data: CommonProcess.keychainLoad("access_token")!, encoding:NSUTF8StringEncoding)
        request?.allHTTPHeaderFields = ["auth_token":access_token! as String]
        let dataTask = session.dataTaskWithRequest(request!) { (data, response, error) -> Void in
            // レスポンスが返却されてきた時の処理
            var responseDict = Dictionary<String,AnyObject>()
            if (data != nil) {
                do {
                    responseDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.init(rawValue: 0)) as! Dictionary<String, AnyObject>
                    
                } catch {
                }
                // レスポンスを通知
                handler(response: responseDict, error: error)
            }
        }
        // 通信開始
        dataTask.resume()
        
    }
    
}