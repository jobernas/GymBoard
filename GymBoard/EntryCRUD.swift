//
//  EntryCRUD.swift
//  GymBoard
//
//  Created by João Luís on 04/05/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import Foundation
import RealmSwift

class EntryCRUD {
    
    
    /// Clear DB All Objects
    public static func clearDB() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    /// Delete All Entries For a specific date
    ///
    /// - Parameter date: date YYYY-MM-DD
    public static func deleteEntriesForDate(_ date:String ) {
        do {
            let realm = try Realm()
            let entriesToDelete = EntryCRUD.getDailyEntries(date)
            try! realm.write {
                realm.delete(entriesToDelete)
            }
        }catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Get Daily Entries for a Specific Day
    ///
    /// - Parameter date: date YYYY-MM-DD
    /// - Returns: Array of Entries Objs
    public static func getDailyEntries(_ date:String) -> Results<Entry> {
        do {
            let realm = try Realm()
            return realm.objects(Entry.self).filter("date = %@", date)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        
    }

    /// Get All Entries Available in the Database
    ///
    /// - Returns: Array of Entries Objs
    public static func getAllEntries() -> Results<Entry> {
        do {
            let realm = try Realm()
            return realm.objects(Entry.self) ///.sorted(byKeyPath: "date", ascending: false) NOT works when passing to a dictionary
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Save Entry into DB
    ///
    /// - Parameter entry: Entry Obj
    public static func save(_ entry:Entry) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(entry)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
