//
//  Item.swift
//  Todoey
//
//  Created by Apple on 16/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
