//
//  WelcomeViewController.swift
//  RealmDemo
//
//  Created by Sumit Ghosh on 10/08/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit
import RealmSwift


func initializeRealmPermissions(_ realm: Realm) -> Void {
    let queryable = [Project.className(): true, Item.className():false,PermissionRole.className(): true]
    let updateable = [Project.className(): true,Item.className(): true,PermissionRole.className(): false]
    
    for cls in [Project.self,Item.self,PermissionRole.self] {
        let everyonePermission = realm.permissions(forType: cls).findOrCreate(forRoleNamed: "everyone")
        everyonePermission.canQuery = queryable[cls.className()]!
        everyonePermission.canUpdate = updateable[cls.className()]!
        everyonePermission.canSetPermissions = false
    }
    
    let everyonePermission = realm.permissions.findOrCreate(forRoleNamed: "everyone")
    everyonePermission.canModifySchema = false
    everyonePermission.canSetPermissions = false
}

func initializePermissions(_ user:SyncUser, completion:@escaping(Error?) -> Void) {
    
    Realm.asyncOpen(configuration: SyncConfiguration.automatic(user: user)) { (realm, error) in
        
        guard let realm = realm else {
            completion(error)
            return
        }
        
        try! realm.write {
            initializeRealmPermissions(realm)
        }
        completion(nil)
    }
    
}


class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Welcome"
        
        if let _ = SyncUser.current {
            //We have already logged in here!
            self.navigationController?.viewControllers = [ProjectsViewController()]
        }else{
            let alertController = UIAlertController(title: "Login to Realm Cloud", message: "Supply a nice nickname", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: { [unowned self]
                alert -> Void in
                
                let textField = alertController.textFields![0] as UITextField
                let creds = SyncCredentials.nickname(textField.text!, isAdmin: true)
                
                SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: { [weak self](user, err) in
                    if let _ = user {
                        self?.navigationController?.viewControllers = [ProjectsViewController()]
                    } else if let error = err {
                        fatalError(error.localizedDescription)
                    }
                })            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
               textField.placeholder = "A name for your user"
            })
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
