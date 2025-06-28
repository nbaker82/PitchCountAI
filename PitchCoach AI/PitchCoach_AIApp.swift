//
//  PitchCoach_AIApp.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/17/25.
//

import SwiftData
import SwiftUI

@main
struct PitchCoach_AIApp: App {
    var body: some Scene {
        WindowGroup {
            TeamListView()
                .background(ColorTheme.background)
                .preferredColorScheme(.light) // You can change this to .dark or .none based on your preference
        }
        .modelContainer(for: [Team.self, Player.self, PitchLog.self])
    }
}
