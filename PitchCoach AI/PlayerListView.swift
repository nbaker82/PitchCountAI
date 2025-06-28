//
//  PlayerListView.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/17/25.
//
import SwiftUI
import SwiftData

struct PlayerListView: View {
    @Bindable var team: Team
    @Environment(\.modelContext) private var context
    @State private var isPresentingAddPlayer = false
    @State private var newPlayer: Player?
    @State private var selectedPlayer: Player?
    
    var body: some View {
        List {
            ForEach(team.players) { player in
                Button {
                    selectedPlayer = player
                } label: {
                    VStack(alignment: .leading) {
                        Text("\(player.firstName) \(player.lastName)")
                            .font(.headline)
                            .foregroundColor(ColorTheme.textPrimary)

                        if let daysLeft = daysUntilReady(for: player), daysLeft > 0 {
                            Text("🕒 Ready in \(daysLeft) day\(daysLeft > 1 ? "s" : "")")
                                .font(.subheadline)
                                .foregroundColor(ColorTheme.cooldown)
                        } else {
                            Text("✅ Ready")
                                .font(.subheadline)
                                .foregroundColor(ColorTheme.ready)
                        }
                    }
                }
            }
            .onDelete(perform: deletePlayers)

        }
        .listStyle(.plain)
        .background(ColorTheme.background)
        .navigationTitle(team.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let player = Player(
                        firstName: "",
                        lastName: "",
                        age: 0,
                        throwingArm: .right,
                        position: "Pitcher",
                        team: team
                    )
                    team.players.append(player)
                    newPlayer = player
                    isPresentingAddPlayer = true
                } label: {
                    Label("Add Player", systemImage: "plus")
                        .foregroundColor(ColorTheme.primary)
                }
            }
        }
        .sheet(item: $selectedPlayer) { playerToShow in
            PlayerFormView(player: playerToShow)
        }
        .sheet(isPresented: $isPresentingAddPlayer) {
            if let newPlayer {
                PlayerFormView(player: newPlayer)
            }
        }
        
    }
    
    private func deletePlayers(at offsets: IndexSet) {
        for index in offsets {
            let playerToDelete = team.players[index]
            context.delete(playerToDelete)
        }
    }
    
    func daysUntilReady(for player: Player, cooldownDays: Int = 4) -> Int? {
        guard let lastPitchDate = player.pitchLogs.sorted(by: { $0.date > $1.date }).first?.date else {
            return nil // No pitch logs yet
        }

        let calendar = Calendar.current
        let daysSinceLastPitch = calendar.dateComponents([.day], from: lastPitchDate, to: Date()).day ?? 0
        let remainingDays = cooldownDays - daysSinceLastPitch
        return max(remainingDays, 0)
    }
}

