import VLstackNamespace
import SwiftUI

extension VLstack
{
 internal struct SplashLineShape: Shape
 {
  private let size: CGFloat
  private let padding: CGFloat
  private let negativePadding: CGFloat
  private let radius: CGFloat

  init(size: CGFloat)
  {
   self.size = size
   self.padding = max(32, min(64, size * 0.5))
   self.negativePadding = -padding
   self.radius = size / 2 + padding
  }

  func path(in rect: CGRect) -> Path
  {
   return Path
   {
    path in

    path.move(to: CGPoint(x: 0, y: negativePadding))
    path.addLine(to: CGPoint(x: rect.midX, y: negativePadding))

    path.move(to: CGPoint(x: rect.midX, y: negativePadding))
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                radius: radius,
                startAngle: .init(degrees: 270),
                endAngle: .init(degrees: 90),
                clockwise: false)

    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                radius: radius,
                startAngle: .init(degrees: 90),
                endAngle: .init(degrees: 270),
                clockwise: false)

    path.addLine(to: CGPoint(x: rect.maxX, y: negativePadding))
   }
  }
 }
}
