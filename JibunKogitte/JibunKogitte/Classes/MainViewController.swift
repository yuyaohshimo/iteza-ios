//
//  MainViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController,CloudOceanNumericKeypadDelegate {

    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    // MARK: - View読み込み時の処理
    override func viewDidLoad() {
        super.viewDidLoad()

        // ユーザー登録してあれば、お札を表示
        let access_token = CommonProcess.keychainLoad("access_token")
        if (access_token != nil) {
            let access_tokenString = String(data: access_token!, encoding: NSUTF8StringEncoding)
            print(access_tokenString)
        } else {
            // なければ、OAuth画面へ遷移する
            let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(OAuthViewController)
            presentViewController(vc, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // segue.identifierの値により、処理を分ける
        if segue.identifier != nil {
            let identifier = segue.identifier!
            switch identifier {
            case "inputAmount":
                // delegateを設定する
                let vc = segue.destinationViewController as! CloudOceanNumericKeypadViewController
                vc.delegate = self
                
                break
            case "showSettings":
                break
                
            default:
                break
                
            }
        }
        
    }
        
    // MARK: - CloudOceanNumericKeypadDelegate
    func enterValue(intValue: Int) {
        // ボタンのタイトルに反映
        self.amountButton.setTitle("¥ \(intValue)", forState: .Normal)
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
    }
}



