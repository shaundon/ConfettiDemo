//
//  Haptics.swift
//  ConfettiDemo
//
//  Created by Shaun Donnelly on 15/02/2022.
//

import Foundation
import CoreHaptics
import UIKit

struct Haptics {
  var engine: CHHapticEngine?

  init() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
      engine = nil
      return
    }

    do {
      engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("There was an error creating the engine: \(error.localizedDescription)")
      engine = nil
    }
  }

  func poppingSensation() {
    var events = [CHHapticEvent]()

    events.append(
      CHHapticEvent(
        eventType: .hapticTransient,
        parameters: [
          CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
          CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        ],
        relativeTime: 0
      )
    )
    events.append(
      CHHapticEvent(
        eventType: .hapticTransient,
        parameters: [
          CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
          CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        ],
        relativeTime: 0.1
      )
    )

    play(events: events)
  }

  private func play(events: [CHHapticEvent]) {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

    // convert those events into a pattern and play it immediately
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern: \(error.localizedDescription).")
    }
  }
}



