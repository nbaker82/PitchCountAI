//
//  ColorTheme.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/22/25.
//

import SwiftUI

struct ColorTheme {
    // MARK: - Brand & UI Colors
    static let primary = Color("Primary") // Navy Blue
    static let accentGreen = Color("AccentGreen") // Lime Green
    static let accentOrange = Color("AccentOrange") // Orange
    static let background = Color("LightGray") // Light Gray
    static let card = Color("White") // White

    // MARK: - Status Colors
    static let ready = accentGreen          // Lime Green
    static let cooldown = accentOrange      // Orange
    static let overused = Color.red         // (Optional) Red for overuse

    // MARK: - Text
    static let textPrimary = primary        // Navy Blue
    static let textSecondary = Color.gray   // Medium gray for secondary text

    // MARK: - Charts
    static let chartLine = accentGreen
    static let chartWarning = accentOrange
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
