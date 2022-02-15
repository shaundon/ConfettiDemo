//
//  PressActions.swift
//  ConfettiDemo
//
//  Created by Shaun Donnelly on 15/02/2022.
//

import Foundation
import SwiftUI

/// Add an `onPress` and `onRelease` action
/// to a view.
struct PressActions: ViewModifier {
  var onPress: () -> Void
  var onRelease: () -> Void

  func body(content: Content) -> some View {
    content.simultaneousGesture(
      DragGesture(minimumDistance: 0)
        .onChanged({ _ in
          onPress()
        })
        .onEnded({ _ in
          onRelease()
        })
    )
  }
}
