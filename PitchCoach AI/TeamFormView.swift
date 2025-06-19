//
//  TeamFormView.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/18/25.
//
import SwiftUI
import SwiftData

struct TeamFormView: View {
    @Bindable var team: Team
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var body: some View {
        Form {
            Section(header: Text("Team Info")) {
                TextField("Team Name", text: $team.name)
                    .autocapitalization(.words)
            }
        }
        .navigationTitle("Team Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    // Remove if no valid name entered
                    if team.name.trimmingCharacters(in: .whitespaces).isEmpty {
                        context.delete(team)
                    }
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    dismiss()
                }
                .disabled(team.name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}

