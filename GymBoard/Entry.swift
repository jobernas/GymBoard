//
//  Entry.swift
//  GymBoard
//
//  Created by João Luís on 08/03/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//
import UIKit

class Entry : NSObject {

    var unit: String {
        didSet {
            //after change execute this
        }
    }
    var value: Double
    var label: Entry.type

    enum type{
        case Weight
        case BodyMassIndex
        case LeanMass
        case FatMass
        case Age
        case Height
        case Water
    }
    
    init(label: Entry.type, unit: String, value:Double) {
        self.label = label
        self.unit = unit
        self.value = value
    }
    
    fileprivate var _computerVar: Int = 0
    var computerVar: Int{
        get {
            return _computerVar
        }
        set(computerVar) {
            _computerVar = computerVar
        }

    }
}
