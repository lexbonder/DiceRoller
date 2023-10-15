//
//  DiceController.swift
//  DiceRoller
//
//  Created by Alex Bonder on 10/15/23.
//

import Foundation

enum Dice: String, CaseIterable, Identifiable {
    case d4, d6, d8, d10, d100, d12, d20
    var id: Self { self }

    var max: Int {
        switch self {
        case .d4:
            4
        case .d6:
            6
        case .d8:
            8
        case .d10:
            10
        case .d100:
            100
        case .d12:
            12
        case .d20:
            20
        }
    }
}

struct DiceRoll: Identifiable {
    var id = UUID()
    let die: Dice
    let value: Int
}

class DiceController: ObservableObject {
    @Published private(set) var rollHistory = [DiceRoll]()

    
    func roll(die: Dice) -> Int {
        let value = Int.random(in: 1...die.max)
        
        rollHistory.append(DiceRoll(die: die, value: value))
        return value
    }
}
