//
//  ConfettiView.swift
//  ConfettiDemo
//
//  Created by Shaun Donnelly on 15/02/2022.
//

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
  @Binding var isVisible: Bool

  func makeUIView(context: Context) -> UIConfettiView {
    let confettiView = UIConfettiView()
    confettiView.setUp(isOn: isVisible)
    return confettiView
  }

  func updateUIView(_ uiView: UIConfettiView, context: Context) {
    if isVisible {
      uiView.start()
    }
    else {
      uiView.stop()
    }
  }
}

enum ConfettiShape {
  case rectangle
  case circle
  case square
  case triangle
  case star
  
  var size: CGFloat {
    switch self {
    case .rectangle: return 4
    case .circle: return 4
    case .square: return 4
    case .triangle: return 6
    case .star: return 6
    }
  }
  
  func image(color: UIColor) -> UIImage {
    switch self {
      
    case .rectangle:
      let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size * 1.6))
      let path = CGPath(rect: rect, transform: nil)
      return UIGraphicsImageRenderer(size: rect.size).image { context in
        context.cgContext.setFillColor(color.cgColor)
        context.cgContext.addPath(path)
        context.cgContext.fillPath()
      }
      
    case .circle:
      let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
      return UIGraphicsImageRenderer(size: rect.size).image { context in
        context.cgContext.setFillColor(color.cgColor)
        context.cgContext.addEllipse(in: rect)
        context.cgContext.drawPath(using: .fill)
      }
      
    case .square:
      let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
      let path = CGPath(rect: rect, transform: nil)
      return UIGraphicsImageRenderer(size: rect.size).image { context in
        context.cgContext.setFillColor(color.cgColor)
        context.cgContext.addPath(path)
        context.cgContext.fillPath()
      }
      
    case .triangle:
      let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
      let path = CGPath.triangle(withSize: size)
      return UIGraphicsImageRenderer(size: rect.size).image { context in
        context.cgContext.setFillColor(color.cgColor)
        context.cgContext.addPath(path)
        context.cgContext.fillPath()
      }
      
    case .star:
      let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
      let path = CGPath.star(withSize: size)
      return UIGraphicsImageRenderer(size: rect.size).image { context in
        context.cgContext.setFillColor(color.cgColor)
        context.cgContext.addPath(path)
        context.cgContext.fillPath()
      }
    }
  }
}

struct Confetti {
  let shape: ConfettiShape
  let color: UIColor
  let size: CGFloat = 6.0

  var image: UIImage {
    return shape.image(color: color)
  }
}

public final class UIConfettiView: UIView {

  func setUp(isOn: Bool) {
    let emitter = Emitter()
    emitter.configure()
    emitter.frame = self.bounds
    emitter.needsDisplayOnBoundsChange = true
    emitter.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: -50)
    emitter.emitterShape = .line
    self.layer.addSublayer(emitter)
  }

  func stop() {
    if let emitter = getEmitterFromSublayer() {
      emitter.scale = 0.0
    }
  }

  func start() {
    if let emitter = getEmitterFromSublayer() {
      emitter.scale = 1.0
    }
  }

  private func getEmitterFromSublayer() -> Emitter? {
    if let sublayer = self.layer.sublayers?.first,
       let emitter = sublayer as? Emitter {
      return emitter
    }
    return nil
  }
}

class Emitter: CAEmitterLayer {
  func configure() {
    emitterCells = [
      
      // Customise these however you want, with different shapes and colours.
      getCells(withConfetti: Confetti(shape: .circle, color: UIColor.systemYellow)),
      getCells(withConfetti: Confetti(shape: .rectangle, color: UIColor.systemRed)),
      getCells(withConfetti: Confetti(shape: .triangle, color: UIColor.systemGreen)),
      getCells(withConfetti: Confetti(shape: .circle, color: UIColor.systemTeal)),
      getCells(withConfetti: Confetti(shape: .star, color: UIColor.systemPink)),
      getCells(withConfetti: Confetti(shape: .square, color: UIColor.systemPurple))
    ]
  }

  func getCells(withConfetti confetti: Confetti) -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.birthRate = 50.0
    cell.lifetime = 10.0
    cell.velocity = 1000.0
    cell.velocityRange = 100.0
    cell.emissionLongitude = .pi
    cell.emissionRange = .pi / 2
    cell.spinRange = .pi * 8
    cell.scaleRange = 0.25
    cell.scale = 1.0 - cell.scaleRange
    cell.contents = confetti.image.cgImage
    cell.color = confetti.color.cgColor
    return cell
  }
}

struct ConfettiView_Previews: PreviewProvider {
  static var previews: some View {
    ConfettiView(isVisible: .constant(true))
  }
}
