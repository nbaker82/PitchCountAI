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
        .background(ColorTheme.background)
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
                .foregroundColor(ColorTheme.secondary)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    dismiss()
                }
                .foregroundColor(ColorTheme.primary)
                .disabled(team.name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}

