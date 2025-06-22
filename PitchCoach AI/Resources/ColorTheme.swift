//
//  ColorTheme.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/22/25.
//

import SwiftUI

struct ColorTheme {
    // MARK: - Brand & UI Colors
    static let primary = Color.blue // Team Blue
    static let secondary = Color.indigo     // Indigo
    static let highlight = Color.teal     // Sky Blue
    static let background = Color(.systemGroupedBackground)   // Light Gray
    static let card = Color(.systemBackground)              // White or subtle gray

    // MARK: - Status Colors
    static let ready = Color.green          // Green
    static let cooldown = Color.orange      // Orange
    static let overused = Color.red     // Red

    // MARK: - Text
    static let textPrimary = Color.primary // Dark gray
    static let textSecondary = Color.secondary // Medium gray

    // MARK: - Charts
    static let chartLine = highlight
    static let chartWarning = overused
}
