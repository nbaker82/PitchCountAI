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
                                .foregroundColor(ColorTheme.textPrimary)
                        } icon: {
                            Text("\(team.players.count)")
                                .frame(width: 24)
                                .background(Circle().fill(ColorTheme.primary.opacity(0.2)))
                                .foregroundColor(ColorTheme.primary)
                        }
                    }
                }
                .onDelete(perform: deleteTeams)
            }
            .listStyle(.plain)
            .background(ColorTheme.background)
            .navigationTitle("Teams")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newTeam = Team(name: "")
                        context.insert(newTeam)
                        isPresentingAddTeam = true
                    } label: {
                        Label("Add Team", systemImage: "plus")
                            .foregroundColor(ColorTheme.primary)
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddTeam) {
                NavigationStack {
                    TeamFormView(team: newTeam)
                }
            }
        }
        .background(ColorTheme.background)
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
