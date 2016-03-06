//
//  SettingViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var userInfos = Array<AnyObject>()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // ユーザー情報を取得し、反映する
        
        // 写真を取得して表示する
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        fetchRequest.entity = entity
        do {
            let pictures = try CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCheckData]
            if pictures.count > 0 {
                let picture = pictures[pictures.count - 1] as MyCheckData
                let profileImage = UIImage(data: picture.profileImage!)
                self.profileImageView.image = profileImage
            }
        } catch {
        } 
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
        return userInfos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath)
        return cell
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

            // 写真をCoreDataに追加
            let fetchRequest = NSFetchRequest()
            let entity = NSEntityDescription.entityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
            fetchRequest.entity = entity
            do {
                let pictures = try CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCheckData]
                if pictures.count > 0 {
                    let picture = pictures[0] as MyCheckData
                    picture.profileImage = UIImagePNGRepresentation(image)
                    try CoreDataManager.sharedInstance.managedObjectContext.save()
                }
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
        }
    }
}
