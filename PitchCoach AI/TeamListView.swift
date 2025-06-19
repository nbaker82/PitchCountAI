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
    @State private var isPresentingAddTeam = false
    @State private var newTeam = Team(name: "")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(teams) { team in
                    NavigationLink {
                        PlayerListView(team: team)
                    } label: {
                        Label {
                            Text(team.name)
                        } icon: {
                            Text("\(team.players.count)")
                                .frame(width: 24)
                                .background(Circle().fill(Color.blue.opacity(0.2)))
                        }
                    }
                }
                .onDelete(perform: deleteTeams)
            }
            .navigationTitle("Teams")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newTeam = Team(name: "")
                        context.insert(newTeam)
                        isPresentingAddTeam = true
                    } label: {
                        Label("Add Team", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddTeam) {
                NavigationStack {
                    TeamFormView(team: newTeam)
                }
            }
        }
    }
    
    private func deleteTeams(at offsets: IndexSet) {
        for index in offsets {
            let teamToDelete = teams[index]
            context.delete(teamToDelete)
        }
    }
}

#Preview {
    TeamListView()
}
