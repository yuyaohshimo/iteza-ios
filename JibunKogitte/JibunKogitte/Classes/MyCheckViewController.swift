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
    
    
    @IBAction func pressCloseButton(sender: UIBarButtonItem) {
        SessionSingletonData.sharedInstance.amount = -1
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
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let amountString = currencyFormatter.stringFromNumber(SessionSingletonData.sharedInstance.amount)
        if amountString != nil {
            amountLabel.text = "¥" + amountString!
        }
        
        // 送信先
        
        // 発行日
        
        // 振出人


        // Do any additional setup after loading the view.
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
