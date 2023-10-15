//
//  RollHistoryView.swift
//  DiceRoller
//
//  Created by Alex Bonder on 10/15/23.
//

import SwiftUI

struct RollHistoryView: View {
    @EnvironmentObject var diceRoller: DiceController
    @State private var showingNewestFirst = true

    var rollList: [DiceRoll] {
        showingNewestFirst ? diceRoller.rollHistory.reversed() : diceRoller.rollHistory
    }

    var body: some View {
        List {
            ForEach(rollList) { roll in
                HStack {
                    Text(roll.die.rawValue)
                    Spacer()
                    Text("\(roll.value)")
                        .foregroundStyle(styleValue(die: roll.die, value: roll.value))
                }
            }
        }
        .toolbar {
            Button {
                showingNewestFirst.toggle()
            } label: {
                Text(showingNewestFirst ? "Newest → Oldest" : "Oldest → Newest")
            }
        }
        
    }
    
    func styleValue(die: Dice, value number: Int) -> Color {
        if number == 1 {
            return .red
        } else if number == die.max {
            return .green
        } else {
            return .primary
        }
    }
}

#Preview {
    NavigationView {
        RollHistoryView()
            .environmentObject(DiceController())
    }
}
