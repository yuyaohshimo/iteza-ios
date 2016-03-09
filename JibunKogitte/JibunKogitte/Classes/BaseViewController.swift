//
//  BaseViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/06.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit
import MobileCoreServices


class BaseViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    // Segue名
    let SegueShowSettings = "showSettings"
    let SegueInputAmount = "inputAmount"
    let SegueSettings = "Settings"
    let SegueInitialRegieterProfile = "initialRegieterProfile"
    
    // ViewController名
    let VcOAuthViewController = "OAuthViewController"
    let VcRegisterUserImageViewController = "RegisterUserImageViewController"
    let VcOAuthNavigationViewController = "OAuthNavigationViewController"
    let VcCloudOceanNumericKeypadViewController = "CloudOceanNumericKeypadViewController"
    
    // StotyBoard名
    let MainStoryBoard = "Main"
    let SettingsStoryBoard = "Settings"
    let RegisterBoard = "Register"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    //　MARK: - ImagePickerViewを表示する
    func presentImagePickerViewController (sourceType:UIImagePickerControllerSourceType) {
        // Pickerを設定
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = sourceType
        // 静止画のみ
        picker.mediaTypes = [kUTTypeImage as String]
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true) { () -> Void in
            // 写真を変更
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // 閉じるだけ
        picker.dismissViewControllerAnimated(true, completion: nil)
    }


}
