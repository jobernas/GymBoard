//
//  String.swift
//  GymBoard
//
//  Created by João Luís on 25/05/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import Foundation

extension String {
    
    var isDouble: Bool {
        return Double(self) != nil
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }

}
