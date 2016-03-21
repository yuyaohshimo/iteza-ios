//
//  VerifyViewController.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/21.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class VerifyViewController: BaseViewController,UITextFieldDelegate {

    // accountId
    var accountId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tokenTextField: UITextField!

    @IBAction func pressOKButton(sender: UIButton) {
        let verifyModel = VerityModel()
        var reqParam = Dictionary<String,AnyObject>()
        reqParam[VerityModel.ReqVerifyToken] = tokenTextField.text
        reqParam[VerityModel.ReqVerifyAccountId] = accountId
        
        verifyModel.startConnection(reqParam) { (response, httpResponse, error) -> Void in
            print(response)
            // TOKENをキーチェーンに登録
            if (response["auth_token"] != nil) {
                let auth_token = response[VerityModel.ResVerifyAuthToken] as? String
                CommonProcess.clear();
                CommonProcess.keychainSave("auth_token", data: (auth_token?.dataUsingEncoding(NSUTF8StringEncoding))!)
            }
            self.dispatch_async_main({ () -> () in
                self.performSegueWithIdentifier(self.SegueInitialRegieterProfile, sender: nil)
            })
            
        };

    }
    
    @IBAction func pressCancelButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
