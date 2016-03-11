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

    
    // MARK: - View読み込み時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザー登録してあれば、電卓画面を表示
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        fetchRequest.entity = entity
        do {
            let pictures = try CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCheckData]
            if pictures.count == 0 {
                // なければ、OAuth画面へ遷移する
                let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthNavigationViewController) as! UINavigationController
                let oAthVC = vc.visibleViewController as! OAuthViewController
                oAthVC.isInitialRegister = true
                presentViewController(vc, animated: true, completion:nil)

            } else {
                // ユーザの写真を取得し、あったら小切手の金額入力を行う
                let vc = storyboard!.instantiateViewControllerWithIdentifier(VcCloudOceanNumericKeypadViewController) as! CloudOceanNumericKeypadViewController
                vc.delegate = self
                presentViewController(vc, animated: false, completion: nil)
            }
        } catch {
            let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthViewController) as! OAuthViewController
            vc.isInitialRegister = true
            presentViewController(vc, animated: true, completion:nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
 
    // MARK: - CloudOceanNumericKeypadDelegate
    func enterValue(intValue: Int) {
        // 金額を入力したので、小切手を発行する
        // 小切手発行画面へ
        let vc = storyboard!.instantiateViewControllerWithIdentifier(VcMyCheckNavigationController) as! UINavigationController
        let checkVc = vc.viewControllers.first as! MyCheckViewController
        let issueCheckModel = IssueCheckModel()
        let reqParam = Dictionary<String,String>()
        
        issueCheckModel.startConnection(reqParam) { (response, error) -> Void in
            print("発行しました")
            checkVc.amount = intValue
            self.presentViewController(vc, animated: true, completion: nil)
        }

    }
    
}



