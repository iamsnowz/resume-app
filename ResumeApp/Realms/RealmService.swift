//
//  RealmService.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

class RealmService {
    private init() { }
    static let shared = RealmService()
    
    var realm: Realm {
        get {
            do {
                return try Realm()
            } catch {
                print("Could not access database: ", error)
            }
            return self.realm
        }
    }
    
    // Write data into Realm database
    func saveObjects(objs: Object) {
        do {
            try realm.write {
                realm.add(objs)
            }
        } catch {
            print("Could not write to database: ", error)
        }
    }
    
    // Delete particular object from realm database
    func deleteObjects(objs: Object) {
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch {
            print("Could not delete to database: ", error)
        }
    }
}
