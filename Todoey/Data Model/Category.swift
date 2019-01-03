//
//  Category.swift
//  Todoey
//
//  Created by Gustavo Bentemuller Junior on 03/01/19.
//  Copyright © 2019 BENT. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
