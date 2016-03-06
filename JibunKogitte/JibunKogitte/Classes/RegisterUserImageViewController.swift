//
//  RegisterUserImageViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit



class RegisterUserImageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // ユーザーがなければ
        performSegueWithIdentifier("initialOAuth", sender: nil)
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
