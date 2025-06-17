//
//  ContentView.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/17/25.
//

import SwiftUI
import SwiftData

struct TeamListView: View {
    @Query private var teams: [Team]
    @Environment(\.modelContext) private var context
    @State private var newTeamName = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(teams) { team in
                    NavigationLink(team.name) {
                        PlayerListView(team: team)
                    }
                }
            }
            .navigationTitle("Teams")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Add Team") {
                        let team = Team(name: "New Team")
                        context.insert(team)
                    }
                }
            }
        }
    }
}

#Preview {
    TeamListView()
}
