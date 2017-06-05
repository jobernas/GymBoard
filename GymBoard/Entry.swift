//
//  Entry.swift
//  GymBoard
//
//  Created by João Luís on 08/03/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//
import Foundation
import RealmSwift

class Entry : Object {
    
    static let TYPE_UNKNOWN = -1
    static let TYPE_WEIGHT = 0
    static let TYPE_BMI = 1
    static let TYPE_FAT_MASS = 2
    static let TYPE_WATER = 3
    static let TYPE_PHYSICAL_EVAL = 4
    static let TYPE_BONE_MASS = 5
    static let TYPE_BMR = 6
    static let TYPE_IDDMET = 7
    static let TYPE_VIS_FAT = 8
    
    dynamic var id = NSUUID().uuidString
    dynamic var type: Int = Entry.TYPE_UNKNOWN
    dynamic var unit: String = "Unknown"
    dynamic var value: Double = 0.0
    dynamic var date: String = "DD-MM-YYYY"

    
    /// Primary Key So it Can be updated
    ///
    /// - Returns: String ID
    override class func primaryKey() -> String? {
        return "id"
    }
    
    /// Get Label for Entry type
    ///
    /// - Returns: String with label
    func getLabel() -> String {
        switch self.type {
        case Entry.TYPE_WEIGHT:
            return "Weight:"
        case Entry.TYPE_BMI:
            return "BMI:"
        case Entry.TYPE_FAT_MASS:
            return "Fat Mass:"
        case Entry.TYPE_WATER:
            return "Water:"
        case Entry.TYPE_PHYSICAL_EVAL:
            return "Physical Evaluation:"
        case Entry.TYPE_BONE_MASS:
            return "Bone Mass:"
        case Entry.TYPE_BMR:
            return "BMR:"
        case Entry.TYPE_IDDMET:
            return "IDD Met:"
        case Entry.TYPE_VIS_FAT:
            return "Visceral Fat:"
        default:
            return "Unknown"
        }
    }
    
    /// save into DB
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    // Update into DB    
    func update(key: Int?, date:String?, value:Double?, unit:String?) {
        do {
            let realm = try Realm()
            try realm.write {
                self.type = key ?? self.type
                self.date = date ?? self.date
                self.value = value ?? self.value
                self.unit = unit ?? self.unit
                realm.add(self, update: true)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
