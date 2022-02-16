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
    
    var realm = try! Realm()
    
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
    
    // Update the obect
    func updateObjects(objs: Object) {
        do {
            try realm.write {
                realm.add(objs, update: .all)
            }
        } catch {
            print("Could not update to database: ", error)
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
