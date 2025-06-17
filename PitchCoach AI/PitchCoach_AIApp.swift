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
        }
        .modelContainer(for: [Team.self, Player.self, PitchLog.self])
    }
}
