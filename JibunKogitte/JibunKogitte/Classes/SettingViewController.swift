//
//  SettingViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath)
        return cell
    }
    
    // MARK: - 画面回転
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    override func shouldAutorotate() -> Bool {
        return true
    }

    @IBAction func pressChangePicture(sender: UIButton) {
        
        // 写真を変更する
        let alertController = UIAlertController(title: "写真を変更", message: nil, preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: "新しい写真を撮る", style: .Default, handler: { (action) -> Void in
            self.presentImagePickerViewController(UIImagePickerControllerSourceType.Camera)
        }))
        alertController.addAction(UIAlertAction(title: "保存済みの写真を選択", style: .Default, handler: { (action) -> Void in
            self.presentImagePickerViewController(UIImagePickerControllerSourceType.PhotoLibrary)
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    override func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true) { () -> Void in
            // 写真を変更
            self.profileImageView.image = image
        }
    }
}
