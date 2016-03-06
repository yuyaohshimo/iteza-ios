//
//  OAuthViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class OAuthViewController: BaseViewController,UIWebViewDelegate {
    
    @IBOutlet weak var authWebView: UIWebView!
    
    var isInitialRegister = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WebViewでOAuth
        let request = NSURLRequest(URL: NSURL(string: "https://demo-ap08-prod.apigee.net/oauth/authorize?client_id=4kSp7wOSg8Vfg6KIQHZ6wPQi5j4XkaCX&response_type=token")!)
        self.authWebView.delegate = self
        
        // OAuth画面をロードする
        self.authWebView.loadRequest(request)
        
    }
    
    // MARK: - UIWebViewDelegate
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("error")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let fragment = webView.request?.URL?.fragment
        
        if (fragment != nil) {
            let array = fragment!.componentsSeparatedByString("&")
            
            for index in array {
                let item = index as String?
                if (item != nil) {
                    if ((item?.containsString("access_token=")) == true) {
                        let access_token = item?.stringByReplacingOccurrencesOfString("access_token=", withString: "")
                        CommonProcess.keychainSave("access_token", data: (access_token?.dataUsingEncoding(NSUTF8StringEncoding))!)
                        // Viewを閉じる
                        if isInitialRegister == true {
                            performSegueWithIdentifier(SegueInitialRegieterProfile, sender: nil)
                        } else {
                            dismissViewControllerAnimated(true, completion: nil)
                        }
                    }
                }
            }
        }
        
    }
    

    @IBAction func pressCloseButton(sender: UIButton) {
        // Viewを閉じる
        dismissViewControllerAnimated(true, completion: nil)
    }
}
