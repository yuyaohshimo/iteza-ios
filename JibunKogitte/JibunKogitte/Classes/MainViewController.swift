//
//  MainViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: BaseViewController,CloudOceanNumericKeypadDelegate {

    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    // MARK: - View読み込み時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザー登録してあれば、お札を表示
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        fetchRequest.entity = entity
        do {
            let pictures = try CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCheckData]
            if pictures.count > 0 {
                let picture = pictures[pictures.count - 1] as MyCheckData
                let profileImage = UIImage(data: picture.profileImage!)
                self.userImageView.image = profileImage
            } else {
                // なければ、OAuth画面へ遷移する
                let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthNavigationViewController) as! UINavigationController
                let oAthVC = vc.visibleViewController as! OAuthViewController
                oAthVC.isInitialRegister = true
                presentViewController(vc, animated: true, completion:nil)

            }
        } catch {
            let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthViewController) as! OAuthViewController
            vc.isInitialRegister = true
            presentViewController(vc, animated: true, completion:nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 画像を変更しておく
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        fetchRequest.entity = entity
        do {
            let pictures = try CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCheckData]
            if pictures.count > 0 {
                let picture = pictures[pictures.count - 1] as MyCheckData
                let profileImage = UIImage(data: picture.profileImage!)
                self.userImageView.image = profileImage
            }
        } catch {
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
    // MARK:回転検知
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        if size.width > size.height {
            // 横向きだった場合,ViewControllerを変更する
          
        }
    }
        
    // MARK: - CloudOceanNumericKeypadDelegate
    func enterValue(intValue: Int) {
        // ボタンのタイトルに反映
        self.amountButton.setTitle("¥ \(intValue)", forState: .Normal)
    }
    
}



