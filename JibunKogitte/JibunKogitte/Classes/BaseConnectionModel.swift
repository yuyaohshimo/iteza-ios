//
//  BaseConnectionModel.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import Foundation

class BaseConnectionModel:NSObject,NSURLSessionDelegate {
    
    // POSTかGETか
    enum Method :Int {
        case POST
        case GET
    }
    
    let urlBaseString = "http://www.fiftyriver.net:3000/api"
    var urlString:String?           // URL
    var requestMethod:Method?       // POST or GET
    var contentType:String?         // ContentType(JSONの時にはapplication/jsonを指定)
    
    // MARK: - 初期処理
    override init() {
        urlString = ""
        requestMethod = .GET
        contentType = ""
    }
    
    // MARK: - データ送信処理
    func startConnection (parameter:Dictionary<String,AnyObject>,handler:(response:Dictionary<String,AnyObject>,httpResponse:NSHTTPURLResponse?, error:NSError?)->Void) -> Void {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        var request:NSMutableURLRequest?
        
        // パラメータを付加する
        var postString:String = ""
        for (key,value) in parameter {
            postString = postString + ("\(key)=\(value)&")
        }
        
        // POSTの場合とそれ以外の場合で処理わけ
        if (requestMethod == .POST) {
            request = NSMutableURLRequest(URL: NSURL(string: urlString!)!)
            do {
                // JSON型の場合
                if (contentType == "application/json") {
                    let jsonData = try NSJSONSerialization.dataWithJSONObject(parameter, options: NSJSONWritingOptions.init(rawValue: 0))
                    let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as! String
                    request?.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
                    request?.addValue(contentType!, forHTTPHeaderField: "Content-Type")
                    request?.addValue(contentType!, forHTTPHeaderField: "Accept")
                } else {
                    request?.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                }
            } catch {
                
            }
            request?.HTTPMethod = "POST"

        } else {
            request = NSMutableURLRequest(URL: NSURL(string: urlString! + postString)!)
        }
        // auth_tokenがあれば追加
        if (CommonProcess.keychainLoad("auth_token") != nil) {
            let auth_token = NSString(data: CommonProcess.keychainLoad("auth_token")!, encoding:NSUTF8StringEncoding)
            request?.addValue(auth_token! as String,forHTTPHeaderField: "auth_token")
        }

        let dataTask = session.dataTaskWithRequest(request!) { (data, response, error) -> Void in
            // レスポンスが返却されてきた時の処理
            var responseDict = Dictionary<String,AnyObject>()
            let httpResponse = response as? NSHTTPURLResponse
            if (data != nil) {
                do {
                    responseDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.init(rawValue: 0)) as! Dictionary<String, AnyObject>
                    
                } catch {
                }
            }
            // レスポンスを通知
            handler(response: responseDict,httpResponse:httpResponse, error: error)
        }
        // 通信開始
        dataTask.resume()
        
    }
}