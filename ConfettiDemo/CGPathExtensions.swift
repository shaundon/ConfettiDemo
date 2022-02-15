//
//  CGPathExtensions.swift
//  ConfettiDemo
//
//  Created by Shaun Donnelly on 15/02/2022.
//

import Foundation
import SwiftUI
import UIKit

extension CGPath {
  
  static func triangle(withSize size: CGFloat) -> CGPath {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: 0, y: size))
    path.addLine(to: CGPoint(x: size/2, y: 0))
    path.addLine(to: CGPoint(x: size, y: size))
    path.addLine(to: CGPoint(x: 0, y: size))
    return path
  }
  
  // From https://stackoverflow.com/q/57448505/1011161
  static func star(withSize size: CGFloat) -> CGPath {
    let path = UIBezierPath()
    let center = CGPoint(x: size / 2.0, y: size / 2.0)
    let xCenter: CGFloat = center.x
    let yCenter: CGFloat = center.y
    let w = size
    let r = w / 2.0
    let flip: CGFloat = -1.0 // use this to flip the figure 1.0 or -1.0
    let polySide = CGFloat(5)
    let theta = 2.0 * Double.pi * Double(2.0 / polySide)
    path.move(to: CGPoint(x: xCenter, y: r * flip + yCenter))
    for i in 1..<Int(polySide) {
      let x: CGFloat = r * CGFloat( sin(Double(i) * theta) )
      let y: CGFloat = r * CGFloat( cos(Double(i) * theta) )
      path.addLine(to: CGPoint(x: x + xCenter, y: y * flip + yCenter))
    }
    path.close()
    return path.cgPath
  }
}


struct CGPathExtensions_Previews: PreviewProvider {
  
  static var triangle: UIImage {
    let size: CGFloat = 60
    let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
    let path = CGPath.triangle(withSize: size)
    return UIGraphicsImageRenderer(size: rect.size).image { context in
      context.cgContext.setFillColor(UIColor(.red).cgColor)
      context.cgContext.addPath(path)
      context.cgContext.fillPath()
    }
  }
  
  static var star: UIImage {
    let size: CGFloat = 60
    let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
    let path = CGPath.star(withSize: size)
    return UIGraphicsImageRenderer(size: rect.size).image { context in
      context.cgContext.setFillColor(UIColor(.blue).cgColor)
      context.cgContext.addPath(path)
      context.cgContext.fillPath()
    }
  }
  
  static var previews: some View {
    Group {
      Image(uiImage: triangle)
        .previewDisplayName("Triangle")
      Image(uiImage: star)
        .previewDisplayName("Star")
    }
    .previewLayout(.sizeThatFits)
  }
}

