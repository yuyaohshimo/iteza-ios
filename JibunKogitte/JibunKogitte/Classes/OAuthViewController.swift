//
//  OAuthViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class OAuthViewController: BaseViewController,UITextFieldDelegate {
    
    // accountId
    var accountId:String = ""
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressCloseButton(sender: UIButton) {
        // Viewを閉じる
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func pressOKButton(sender: UIButton) {
        // キーチェーンの内容をクリアする
        CommonProcess.clear()
        // 電文を送信する
        let loginModel = LoginModel()
        var reqParam = Dictionary<String,AnyObject>()
        reqParam[LoginModel.ReqLoginEmailAddress] = mailAddressTextField.text
        reqParam[LoginModel.ReqLoginPassword] = passwordTextField.text
        
        loginModel.startConnection(reqParam) { (response, httpResponse, error) -> Void in
            print(response)
            // accountIdを取得して、Verify画面へ
            if (response[LoginModel.ResLoginAccountId] != nil) {
                self.accountId = response[LoginModel.ResLoginAccountId] as! String
                self.dispatch_async_main({
                    self.performSegueWithIdentifier(self.SegueShowVerify, sender: nil)
                })
               
            }
        };
    }
    
    // MARK:UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーパッドを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    // MARK:Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueShowVerify {
            // Verify画面に進む場合
            if let vc = segue.destinationViewController as? VerifyViewController {
                vc.accountId = accountId
            }
        }
    }
}
