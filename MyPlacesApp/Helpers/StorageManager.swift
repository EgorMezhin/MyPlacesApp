//
//  StorageManager.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 02.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place){
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place){
        
        try! realm.write {
            realm.delete(place)
        }
    }
}

