//
//  DamageShot.swift
//  DragonFly
//
//  Created by Александр Уткин on 22.01.2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import Foundation

class DamageShot {
    
    static var shared = DamageShot()
    var levelDamageSimple = 0.05
    var levelDamageMiddle = 0.05
    var levelDamageSenior = 0.05
    var typeDamage = TypeDamage.simple
    
    func upgradeDamage() {
        self.levelDamageSimple += 0.05
        if self.levelDamageSimple > 0.20 && self.levelDamageSimple < 0.40 {
            self.typeDamage = .middle
            self.levelDamageMiddle += 0.05
        } else if self.levelDamageSimple > 0.4 && self.levelDamageSimple < 0.60 {
            self.levelDamageMiddle += 0.05
            self.levelDamageSenior += 0.05
            self.typeDamage = .senior
            if self.levelDamageSenior > 0.85 {
                self.levelDamageSenior = 0.85
            }
        }
    }
}

enum TypeDamage {
    case simple
    case middle
    case senior
}
