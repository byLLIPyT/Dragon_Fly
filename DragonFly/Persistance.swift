//
//  Persistance.swift
//  DragonFly
//
//  Created by Александр Уткин on 10.08.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

class Persistance {
    
    static let shared = Persistance()
    private let keyTransaction = "fullVersion"
    
    var isPay: Bool? {
        set { UserDefaults.standard.set(newValue, forKey: keyTransaction) }
        get { return UserDefaults.standard.bool(forKey: keyTransaction) }
    }
}
