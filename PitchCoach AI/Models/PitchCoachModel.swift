
import Foundation
import SwiftData

@Model
class Team {
    var id: UUID
    var name: String
    var players: [Player] = []
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

@Model
class Player {
    var id: UUID
    var firstName: String
    var lastName: String
    var age: Int
    var throwingArm: ThrowingArm
    var position: String
    var pitchTypes: [PitchType] = []
    var team: Team?
    var pitchLogs: [PitchLog] = []
    
    var name: String {
        [firstName, lastName].joined(separator: " ")
    }
    
    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        age: Int,
        throwingArm: ThrowingArm,
        position: String,
        team: Team? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.throwingArm = throwingArm
        self.position = position
        self.team = team
    }
}

enum ThrowingArm: String, Codable, CaseIterable {
    case left = "Left"
    case right = "Right"
}

@Model
class PitchLog {
    var id: UUID
    var date: Date
    var totalPitches: Int
    var player: Player?
    
    init(
        id: UUID = UUID(),
        date: Date = .now,
        totalPitches: Int,
        player: Player? = nil
    ) {
        self.id = id
        self.date = date
        self.totalPitches = totalPitches
        self.player = player
    }
}

enum PitchType: String, Codable, CaseIterable {
    case fastball
    case curveball
    case slider
    case screwwball
    case changeup
    case other
}
