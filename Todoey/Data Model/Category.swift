//
//  Category.swift
//  Todoey
//
//  Created by Apple on 16/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
