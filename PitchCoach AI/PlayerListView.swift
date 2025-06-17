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

    var body: some View {
        List {
            ForEach(team.players) { player in
                NavigationLink(player.name) {
                    PitchLogListView(player: player)
                }
            }
        }
        .navigationTitle(team.name)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add Player") {
                    let player = Player(
                        name: "New Player",
                        age: 12,
                        throwingArm: .right,
                        position: "Pitcher",
                        team: team
                    )
                    team.players.append(player)
                }
            }
        }
    }
}

