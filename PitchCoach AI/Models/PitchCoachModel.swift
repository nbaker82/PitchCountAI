
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
    var name: String
    var age: Int
    var throwingArm: ThrowingArm
    var position: String
    var team: Team?
    var pitchLogs: [PitchLog] = []
    
    init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        throwingArm: ThrowingArm,
        position: String,
        team: Team? = nil
    ) {
        self.id = id
        self.name = name
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
    var pitchTypes: [PitchType]
    var player: Player?
    
    init(
        id: UUID = UUID(),
        date: Date = .now,
        totalPitches: Int,
        pitchTypes: [PitchType] = [],
        player: Player? = nil
    ) {
        self.id = id
        self.date = date
        self.totalPitches = totalPitches
        self.pitchTypes = pitchTypes
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
