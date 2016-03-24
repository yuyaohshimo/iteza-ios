//
//  MainViewController.swift
//  JibunKogitte
//
//  Created by 梶嶋 佐知子 on 2016/03/05.
//  Copyright © 2016年 KOMS. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // キーチェーンを削除しておく
        CommonProcess.clear()
    }
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
                // トークンがなければ、OAuth画面へ遷移する
                if CommonProcess.keychainLoad("auth_token") != nil {
                    self.performSegueWithIdentifier(self.SegueShowMyCheck, sender: nil)
                } else {
                    let vc = UIStoryboard(name: RegisterBoard, bundle: nil).instantiateViewControllerWithIdentifier(VcOAuthNavigationViewController) as! UINavigationController
                    presentViewController(vc, animated: true, completion:nil)

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
        
    }
    
}



