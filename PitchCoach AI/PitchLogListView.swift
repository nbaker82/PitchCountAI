//
//  PitchLogListView.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/17/25.
//

import SwiftUI
import SwiftData

struct PitchLogListView: View {
    @Bindable var player: Player
    @Environment(\.modelContext) private var context

    var body: some View {
        List {
            ForEach(player.pitchLogs.sorted(by: { $0.date > $1.date })) { log in
                VStack(alignment: .leading) {
                    Text("Date: \(log.date.formatted(date: .abbreviated, time: .omitted))")
                        .foregroundColor(ColorTheme.textPrimary)
                    Text("Pitches: \(log.totalPitches)")
                        .foregroundColor(ColorTheme.textSecondary)
                }
            }
        }
        .listStyle(.plain)
        .background(ColorTheme.background)
        .navigationTitle(player.name)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add Pitch Log") {
                    let log = PitchLog(totalPitches: 50, player: player)
                    player.pitchLogs.append(log)
                }
                .foregroundColor(ColorTheme.primary)
            }
        }
    }
}
