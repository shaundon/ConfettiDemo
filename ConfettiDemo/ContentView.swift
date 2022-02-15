//
//  ContentView.swift
//  ConfettiDemo
//
//  Created by Shaun Donnelly on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
  @State private var confettiVisible = false
  
  // Initialise the taptic engine.
  let haptics = Haptics()
  
  var showForOneSecondButton: some View {
    Button(action: {
      confettiVisible = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        confettiVisible = false
      }
    }) {
      Text("Show confetti for 1 second")
    }
  }
  
  var pressAndHoldButton: some View {
    Button(action: {
      // When button is tapped, show confetti just
      // for a moment.
      confettiVisible = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        confettiVisible = false
      }
    }) {
      Text("Tap, or press and hold for confetti")
    }
    // Show confetti continuously while the button
    // is held down.
    .pressAction(
      onPress: {
        confettiVisible = true
        haptics.poppingSensation()
      },
      onRelease: {
        confettiVisible = false
      }
    )
  }
  
  var body: some View {
    VStack(spacing: 10) {
      showForOneSecondButton
      pressAndHoldButton
    }
    .withConfetti(isVisible: $confettiVisible)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
