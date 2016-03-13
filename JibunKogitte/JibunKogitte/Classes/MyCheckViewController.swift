//
//  MyCheckViewController.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/09.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class MyCheckViewController: BaseViewController, CloudOceanNumericKeypadDelegate {
    
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var sendToLabel: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var issueIdLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountText: UILabel!
    @IBOutlet weak var sendToText: UILabel!
    @IBOutlet weak var issueDateText: UILabel!
    @IBOutlet weak var issueIDText: UILabel!
    
    
    var keypadDetelage: CloudOceanNumericKeypadDelegate?
    
    //    let checkyBrandColor1: UIColor = UIColor(red: 0, green: 157, blue: 177, alpha: 1)
    //    let checkyBrandColor2: UIColor = UIColor(red: 0, green: 11, blue: 122, alpha: 1)
    //    let checkyBrandColor2: CGColor = UIColor(red: 0, green: 8, blue: 122, alpha: 1).CGColor
    
    
    var amount: Int = 0
    var accountID: String = ""
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        labelDisplayControl()
    }
    
    
    
    
    //// BackgroundView: 背景の模様。サーバーに送らない。

    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            let backgroundImage = UIImage(named: "ckBgGrayPattern")
            backgroundImageView.backgroundColor = UIColor(patternImage: backgroundImage!)
        }
    }
    
    
    //// FrameView: 飾り付け関連のOutlet
    //　左上だけ特殊。枠線で描画（あとはStoryboardが中心）
    @IBOutlet weak var leftTopMark: UIView! {
        didSet {
            //// なんで青くならない？？？？
            //            let checkyBrandColor2: CGColor = UIColor(red: 0, green: 11, blue: 122, alpha: 1).CGColor
            let checkyBrandColor2: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
            leftTopMark.layer.borderColor = checkyBrandColor2
            leftTopMark.layer.borderWidth = 4.0
        }
    }
    
    @IBOutlet weak var gradationLineTop: UIView! {
        didSet {
            //            let gradation = CAGradientLayer()
            //            gradation.frame = gradationLineTop.bounds
            //            gradation.colors = [checkyBrandColor1.CGColor, checkyBrandColor2.CGColor]
            //            gradation.startPoint = CGPoint(x: 0, y: 0)
            //            gradation.endPoint = CGPoint(x:1, y: 1)
            //            gradationLineTop.layer.insertSublayer(gradation, atIndex: 0)
        }
    }
    
    
    //// MaskView: 全体にかぶせる。ここはサーバーに送らない。
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var maskImageView: UIImageView! {
        didSet {
            let maskImage = UIImage(named: "mask")
            maskImageView.image = maskImage
        }
    }
    
    
    @IBOutlet weak var priceSetButton: UIButton!
    @IBAction func priceSetButtonAction(sender: AnyObject) {
        
        // Numeric Keypad Assign
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let numerickeypad: CloudOceanNumericKeypadViewController = storyboard.instantiateViewControllerWithIdentifier("CloudOceanNumericKeypadViewController") as! CloudOceanNumericKeypadViewController
        
        numerickeypad.delegate = self
        numerickeypad.modalPresentationStyle = .Popover
        presentViewController(numerickeypad, animated: true, completion: nil)
    }
    
    
    
    func enterValue(floatValue: Int) {
        // 値が返ってきている。呼び出したラベルに値をセット
        print("keypad enter = \(floatValue)")
        
        amount = floatValue
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let amountString = currencyFormatter.stringFromNumber(floatValue)
        
        print("amountString = \(amountString)")
        
        amountLabel.text = "¥" + amountString!
    }
    
    
    
    
    
    
    @IBOutlet weak var issueIDButton: UIButton!
    
    @IBAction func issueIDButtonAction(sender: AnyObject) {

        if amount == 0 {
            
            // Display information alert
            let alertMessage = "金額がゼロです。"
            let contentNotFoundAlertController = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            contentNotFoundAlertController.addAction(defaultAction)
            
            presentViewController(contentNotFoundAlertController, animated: true, completion: nil)
            
        }
        else {
        self.issueIdLabel.text = "残高を確認中..."
        
            issueIDGenetate(amount)
        
        }
        
    }
    
    
    
    
    
    
    
    
    @IBOutlet weak var backFromSignButton: UIButton!
    
    @IBAction func backFromButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    @IBAction func pressCloseButton(sender: UIBarButtonItem) {
        // 前の画面に戻る
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        
        // 金額
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let amountString = currencyFormatter.stringFromNumber(SessionSingletonData.sharedInstance.amount)
        if amountString != nil {
            amountLabel.text = "¥" + amountString!
        }
        amount = SessionSingletonData.sharedInstance.amount
        
        // 送信先
        sendToLabel.text = "get@checky.me"
        
        // 発行日
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle
        let outString : String = formatter.stringFromDate(now)
        
        issueDateLabel.text = outString
        
        // 発行ID
        issueIdLabel.text = ""
        
        // サインのテスト
        let signImage = UIImage(named: "signature")
        signImageView.image = signImage
        signImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        // Accountをチェックしておく
        checkAccount()
        
        
        labelDisplayControl ()
    }
    
    
    
    
    func labelDisplayControl () {
        if view.frame.width < view.frame.height {
            amountLabel.hidden = true
            sendToLabel.hidden = true
            issueDateLabel.hidden = true
            issueIdLabel.hidden = true
            
            titleLabel.hidden = true
            amountText.hidden = true
            sendToText.hidden = true
            issueDateText.hidden = true
            issueIDText.hidden = true
        }
        else {
            amountLabel.hidden = false
            sendToLabel.hidden = false
            issueDateLabel.hidden = false
            issueIdLabel.hidden = false
            
            titleLabel.hidden = false
            amountText.hidden = false
            sendToText.hidden = false
            issueDateText.hidden = false
            issueIDText.hidden = false
        }
        
        backgroundView.setNeedsDisplay()
        mainView.setNeedsDisplay()
        contentView.setNeedsDisplay()
        frameView.setNeedsDisplay()
        buttonView.setNeedsDisplay()
        
        self.view.setNeedsDisplay()
    
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        labelDisplayControl ()
    }
    
    
    
    
    func issueIDGenetate(value: Int) {
        let issueCheckModel = IssueCheckModel()
        var reqParam = Dictionary<String,AnyObject>()
        reqParam[issueCheckModel.ReqAmount] = value
        SessionSingletonData.sharedInstance.checkId = accountID
        
        print("reqParam = \(reqParam)")
        
        dispatch_async_background() {
        
        issueCheckModel.startConnection(reqParam) { (response,httpResponse, error) -> Void in
            print("発行しました")
            
            self.dispatch_async_main() {
                self.issueIdLabel.text = response[issueCheckModel.ResCheckId] as? String
            }

            print("response = \(response[issueCheckModel.ResCheckId])")

//            SessionSingletonData.sharedInstance.checkId = response[issueCheckModel.ResCheckId] as? String
            print(SessionSingletonData.sharedInstance.checkId)
            
            }
        }
    }
    
    func checkAccount() {
        let userModel = UserModel.init()
        let request = Dictionary<String,String>()
        
        
        
        userModel.startConnection(request) { (response, httpResponse,error) -> Void in
            let responseUserId = response[userModel.ResUserUserId] as? String
            let responsePhoneNumber = response[userModel.ResUserPhoneNumber] as? String
            let responseAccountId = response[userModel.ResUserAccountId] as? String
            let responseBalance = response[userModel.ResUserBalance] as? Int
            
            if responseAccountId != nil {
                self.accountID = responseAccountId!}
            
            self.issueIdLabel.text = self.accountID + "より引き落とします。"
            
            print("responseAccountId = \(responseAccountId)")
        }
    }

// Backup
//    func checkAccount() {
//        let userModel = UserModel.init()
//        let request = Dictionary<String,String>()
//        userModel.startConnection(request) { (response, httpResponse,error) -> Void in
//            let responseUserId = response[userModel.ResUserUserId] as? String
//            let responsePhoneNumber = response[userModel.ResUserPhoneNumber] as? String
//            let responseAccountId = response[userModel.ResUserAccountId] as? String
//            let responseBalance = response[userModel.ResUserBalance] as? Int
//            
//            if responseAccountId != nil {
//                self.accountID = responseAccountId!}
//            
//            print("responseAccountId = \(responseAccountId)")
//        }
//    }

    
    
    
    
    
    // GDC functions
    func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    func dispatch_async_background(block: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
    
    
    
    
}
