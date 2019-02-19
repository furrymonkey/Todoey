//
//  AppDelegate.swift
//  Todoey
//
//  Created by Apple on 08/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do{
            _ = try Realm()
        }catch{
            print("Error initialising new realm: \(error)")
        }
        migrate()
        return true
    }
    func migrate(){
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
                        newObject?["dateCreated"] = Date()
                    }
                }
        }
        )
        Realm.Configuration.defaultConfiguration = config
    }

}

