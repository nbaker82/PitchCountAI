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
                    HStack {
                        VStack(alignment: .leading) {
                            Text(player.name)
                                .font(.headline)
                            Text("Age: \(player.age)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
                .onDelete(perform: deletePlayers)
                
            }
        }
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
                }
            }
        }
        .sheet(isPresented: $isPresentingAddPlayer) {
            if let newPlayer {
                NavigationStack {
                    PlayerFormView(player: newPlayer)
                }
            }
        }
        
    }
}

