//
//  Item.swift
//  Todoey
//
//  Created by Apple on 16/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import Foundation
import RealmSwift

protocol PrimaryKeyAware {
    var id: Int { get }
    static func primaryKey() -> String?
}

class Problems: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var problemsID: Int = 2
    
    override static func primaryKey() -> String? {
        return "problemsID"
    }
    
    var parentCategory = LinkingObjects(fromType: Boulder.self, property: "problems")
}
