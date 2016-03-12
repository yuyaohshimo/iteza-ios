//
//  RegisterUserImageViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit
import CoreData

class RegisterUserImageViewController: BaseViewController {
    
    lazy var profileImage:UIImage = UIImage()

    
    @IBOutlet weak var bookGenerationButton: UIButton!
    
    @IBAction func bookGenerationButtonAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MainStoryBoard,bundle: nil)
        let vc = UIStoryboard(name: MainStoryBoard, bundle: nil).instantiateViewControllerWithIdentifier("MyCheckViewController") as! MyCheckViewController
        presentViewController(vc, animated: true, completion:nil)
    }

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.profileImageView.image == nil) {
            // 写真を変更する
            let alertController = UIAlertController(title: "写真を設定", message: nil, preferredStyle: .ActionSheet)
            alertController.addAction(UIAlertAction(title: "新しい写真を撮る", style: .Default, handler: { (action) -> Void in
                self.presentImagePickerViewController(UIImagePickerControllerSourceType.Camera)
            }))
            alertController.addAction(UIAlertAction(title: "保存済みの写真を選択", style: .Default, handler: { (action) -> Void in
                self.presentImagePickerViewController(UIImagePickerControllerSourceType.PhotoLibrary)
            }))
            alertController.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // 写真を変更
        self.profileImage = image
        self.profileImageView.image = image
        
        picker.dismissViewControllerAnimated(true) { () -> Void in

        }
    }

    @IBAction func pressRegister(sender: UIButton) {
        // 写真をCoreDataに追加
        let newPicture = NSEntityDescription.insertNewObjectForEntityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext) as? MyCheckData
        if (newPicture != nil) {
            newPicture!.profileImage = UIImagePNGRepresentation(self.profileImage)
            do {
                try CoreDataManager.sharedInstance.managedObjectContext.save()
            
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            } catch {
                
            }
        }
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
