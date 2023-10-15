//
//  ContentView.swift
//  DiceRoller
//
//  Created by Alex Bonder on 10/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diceRoller = DiceController()
    @State private var selectedDie = Dice.d6
    @State private var showingResult = false
    @State private var diceResult = 0
    @State private var showingHistory = false
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Die to roll", selection: $selectedDie) {
                    ForEach(Dice.allCases) {
                        Text($0.rawValue)
                    }
                }
                Button("Roll Die", action: rollDie)
            }
            .navigationTitle("Dice Roller")
            .toolbar {
                Button("Roll History") {
                    showingHistory = true
                }
            }
            .alert("You rolled \(diceResult)", isPresented: $showingResult) {
                Button("Go to history") {
                    showingHistory = true
                }
                Button("Back", role: .cancel) {}
            }
            .navigationDestination(isPresented: $showingHistory) {
                RollHistoryView()
                    .environmentObject(diceRoller)
            }
        }
    }
    
    func rollDie() {
        diceResult = diceRoller.roll(die: selectedDie)
        showingResult = true
    }
}

#Preview {
    ContentView()
}
