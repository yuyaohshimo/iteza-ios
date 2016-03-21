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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        
        // ユーザー登録してあれば、電卓画面を表示
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("MyCheckData", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        fetchRequest.entity = entity
        do {
            let pictures = try CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCheckData]
            if pictures.count == 0 {
                // なければ、OAuth画面へ遷移する
                let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthNavigationViewController) as! UINavigationController
                presentViewController(vc, animated: true, completion:nil)

            } else {
                if SessionSingletonData.sharedInstance.amount > -1 {
                    self.performSegueWithIdentifier(self.SegueShowMyCheck, sender: nil)
                } else {
                    // ユーザの写真を取得し、あったら小切手の金額入力を行う
                    performSegueWithIdentifier(SegueShowInput, sender: nil)
                }

            }
        } catch {
            let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthNavigationViewController) as! UINavigationController
            presentViewController(vc, animated: true, completion:nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueShowInput {
            if let vc = segue.destinationViewController as? CloudOceanNumericKeypadViewController {
                vc.delegate  = self
            }
        }
    }
    
    // MARK: - CloudOceanNumericKeypadDelegate
    func enterValue(intValue: Int) {
        // 金額を入力したので、小切手を発行する
        // 小切手発行画面へ
        let issueCheckModel = IssueCheckModel()
        var reqParam = Dictionary<String,AnyObject>()
        reqParam[IssueCheckModel.ReqAmount] = intValue
        SessionSingletonData.sharedInstance.checkId = ""
        
        issueCheckModel.startConnection(reqParam) { (response,httpResponse, error) -> Void in
            print("発行しました")
            SessionSingletonData.sharedInstance.checkId = response[IssueCheckModel.ResCheckId] as? String
            print(SessionSingletonData.sharedInstance.checkId)
            
        }
        SessionSingletonData.sharedInstance.amount = intValue
    }
    
}



