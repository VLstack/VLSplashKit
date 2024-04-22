import SwiftUI

internal struct VLSplashLineShape: Shape
{
 var size: CGFloat

 func path(in rect: CGRect) -> Path
 {
  return Path
  {
   path in
   let padding: CGFloat = 25

   path.move(to: CGPoint(x: 0, y: -padding))
   path.addLine(to: CGPoint(x: rect.midX, y: -padding))

   path.move(to: CGPoint(x: rect.midX, y: -padding))
   path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
               radius: size / 2 + padding,
               startAngle: .init(degrees: 270),
               endAngle: .init(degrees: 90),
               clockwise: false)

   path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
               radius: size / 2 + padding,
               startAngle: .init(degrees: 90),
               endAngle: .init(degrees: 270),
               clockwise: false)

   path.addLine(to: CGPoint(x: rect.maxX, y: -padding))
  }
 }
}
