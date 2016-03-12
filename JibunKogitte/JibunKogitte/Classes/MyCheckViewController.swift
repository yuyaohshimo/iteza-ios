//
//  MyCheckViewController.swift
//  JibunKogitte
//
//  Created by Sachiko on 2016/03/09.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class MyCheckViewController: BaseViewController {
    

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var sendToLabel: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var issueIdLabel: UILabel!
    
    
//    let checkyBrandColor1: UIColor = UIColor(red: 0, green: 157, blue: 177, alpha: 1)
//    let checkyBrandColor2: UIColor = UIColor(red: 0, green: 11, blue: 122, alpha: 1)
//    let checkyBrandColor2: CGColor = UIColor(red: 0, green: 8, blue: 122, alpha: 1).CGColor
    
    //// MaskView: 飾り付け関連のOutlet
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
    
    
    
    
    
    @IBAction func pressCloseButton(sender: UIBarButtonItem) {
        // 前の画面に戻る
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 金額
        SessionSingletonData.sharedInstance.amount = 1000000

        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let amountString = currencyFormatter.stringFromNumber(SessionSingletonData.sharedInstance.amount)
        if amountString != nil {
            amountLabel.text = "¥" + amountString!
        }
        
        // 送信先
        sendToLabel.text = "test@test.jp"
        
        // 発行日
        issueDateLabel.text = "2016/12/12 12:12"
        
        // 発行ID
        issueIdLabel.text = "1234567890ABCDEFGH"
        
        // サインのテスト
        let signImage = UIImage(named: "SignTest")
        signImageView.image = signImage
        signImageView.contentMode = UIViewContentMode.ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
