//
//  ViewExtensions.swift
//  ConfettiDemo
//
//  Created by Shaun Donnelly on 15/02/2022.
//

import SwiftUI

extension View {
  
  /// Add an `onPress` and `onRelease` action to a view.
  func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
    modifier(PressActions(onPress: { onPress() }, onRelease: { onRelease() }))
  }
  
  func withConfetti(isVisible: Binding<Bool>) -> some View {
    ZStack {
      self
      ConfettiView(isVisible: isVisible)
      // Without this, you won't be able to interact with the underlying
      // view as the invisible ConfettiView will be covering it.
        .allowsHitTesting(false)
    }
  }
}
