//
//  PlayerFormView.swift
//  PitchCoach AI
//
//  Created by Nicholas Baker on 6/18/25.
//

import Charts
import SwiftUI
import SwiftData

struct PlayerFormView: View {
    @Bindable var player: Player
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // Local form state
    @State private var firstName: String
    @State private var lastName: String
    @State private var age: Int
    @State private var throwingArm: ThrowingArm
    @State private var pitchTypes: [PitchType]
    
    init(player: Player) {
        _player = Bindable(player)
        _firstName = State(initialValue: player.firstName)
        _lastName = State(initialValue: player.lastName)
        _age = State(initialValue: player.age)
        _throwingArm = State(initialValue: player.throwingArm)
        _pitchTypes = State(initialValue: player.pitchTypes)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Player Info")) {
                    TextField("First Name", text: $firstName)
                        .autocapitalization(.words)
                    
                    TextField("Last Name", text: $lastName)
                        .autocapitalization(.words)
                    
                    Stepper(value: $age, in: 6...22) {
                        Text("Age: \(age)")
                    }
                    
                    Picker("Throwing Arm", selection: $throwingArm) {
                        ForEach(ThrowingArm.allCases, id: \.self) { arm in
                            Text(arm.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Pitches Thrown")) {
                    ForEach(PitchType.allCases, id: \.self) { pitch in
                        Toggle(pitch.rawValue.capitalized, isOn: Binding(
                            get: { pitchTypes.contains(pitch) },
                            set: { isOn in
                                if isOn {
                                    pitchTypes.append(pitch)
                                } else {
                                    pitchTypes.removeAll { $0 == pitch }
                                }
                            }
                        ))
                    }
                }
                
                Section(header: Text("Last Pitched")) {
                    if let lastLog = player.pitchLogs.sorted(by: { $0.date > $1.date }).first {
                        Text(lastLog.date.formatted(date: .abbreviated, time: .omitted))
                    } else {
                        Text("No games pitched yet")
                            .foregroundStyle(.secondary)
                    }
                }
                Section(header: Text("Pitch Count History")) {
                    if player.pitchLogs.isEmpty {
                        Text("No pitch data available")
                            .foregroundStyle(.secondary)
                    } else {
                        Chart {
                            ForEach(player.pitchLogs.sorted(by: { $0.date < $1.date })) { log in
                                LineMark(
                                    x: .value("Date", log.date),
                                    y: .value("Pitches", log.totalPitches)
                                )
                                .interpolationMethod(.monotone)
                                .foregroundStyle(Color.blue)
                                .symbol(Circle())
                            }
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day, count: 2)) { _ in
                                AxisGridLine()
                                AxisValueLabel(format: .dateTime.month().day())
                            }
                        }
                        .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Player Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // If form was empty, remove player
                        if player.firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
                            player.lastName.trimmingCharacters(in: .whitespaces).isEmpty {
                            context.delete(player)
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Write back to the model
                        player.firstName = firstName.trimmingCharacters(in: .whitespaces)
                        player.lastName = lastName.trimmingCharacters(in: .whitespaces)
                        player.age = age
                        player.throwingArm = throwingArm
                        player.pitchTypes = pitchTypes
                        
                        dismiss()
                    }
                    .disabled(
                        firstName.trimmingCharacters(in: .whitespaces).isEmpty ||
                        lastName.trimmingCharacters(in: .whitespaces).isEmpty
                    )
                }
            }
        }
    }
}
