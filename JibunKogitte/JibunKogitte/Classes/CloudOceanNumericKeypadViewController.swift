//
//  CloudOceanNumericKeypadViewController.swift
//  CloudOcean
//
//  Created by yaz on 2015/10/22.
//  Copyright © 2015年 KUROFUNE. All rights reserved.
//

import UIKit

@objc protocol CloudOceanNumericKeypadDelegate {
    optional func enterValue (intValue: Int)
}

class CloudOceanNumericKeypadViewController: BaseViewController {
    
    // Variables
    var parameter: Int?
    var value: Int = 0
    var delegate: CloudOceanNumericKeypadDelegate?
    
    //Outlet
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var zero3Button: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var escButton: UIButton!
    @IBOutlet weak var backspaceButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    
    
    //小数点の計算ができていない。かけ算、割り算の手直しが必要。
    
    
    //Button Action
    @IBAction func zeroButtonAction(sender: AnyObject) {
        self.value = self.value * 10
        displayToLabel(self.value)
    }
    
    @IBAction func zero3ButtonAction(sender: AnyObject) {
        self.value = self.value * 100
        displayToLabel(self.value)
    }
    
    @IBAction func dotButtonAction(sender: AnyObject) {
        //使う時に作る。
    }
    
    
    @IBAction func oneButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 1
        displayToLabel(self.value)
    }
    
    @IBAction func twoButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 2
        displayToLabel(self.value)
    }

    @IBAction func threeButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 3
        displayToLabel(self.value)
    }
    
    @IBAction func fourButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 4
        displayToLabel(self.value)
    }
    
    @IBAction func fiveButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 5
        displayToLabel(self.value)
    }
    
    @IBAction func sixButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 6
        displayToLabel(self.value)
    }
    
    @IBAction func sevenButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 7
        displayToLabel(self.value)
    }
    
    @IBAction func eightButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 8
        displayToLabel(self.value)
    }
    
    @IBAction func nineButtonAction(sender: AnyObject) {
        self.value = (self.value * 10) + 9
        displayToLabel(self.value)
    }
    
    @IBAction func escButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func backspaceButtonAction(sender: AnyObject) {
        var intValue: Int = Int(self.value)
        intValue = intValue / 10
        self.value = Int(intValue)
        displayToLabel(self.value)
    }
    
    @IBAction func clearButtonAction(sender: AnyObject) {
        self.value = 0
        displayToLabel(self.value)
    }
    
    @IBAction func plusMinusButtonAction(sender: AnyObject) {
        self.value = (self.value * -1)
        displayToLabel(self.value)
    }
    
    @IBAction func minusButtonAction(sender: AnyObject) {
        //使う時に作る。
    }
    
    @IBAction func enterButtonAction(sender: AnyObject) {
        parameter = self.value
        delegate?.enterValue!(parameter!)
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func displayToLabel (setInt: Int) {
        // Currency formatter
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
//        currencyFormatter.locale = NSLocale(localeIdentifier: "ja_JP")

        displayLabel.text = currencyFormatter.stringFromNumber(setInt)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if parameter != nil {
            print("parameter=\(parameter)")
            self.value = parameter!
        }
        
        displayToLabel(self.value)
    }


}
