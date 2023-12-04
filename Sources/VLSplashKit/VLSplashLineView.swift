import SwiftUI

internal
struct VLSplashLineView: View
{
 var size: CGFloat
 var animateLeading: Bool
 var animateTrailing: Bool

 var body: some View
 {
  VLSplashLineShape(size: size)
   .trim(from: animateLeading ? 1 : 0, to: animateTrailing ? 1 : 0)
   .stroke(LinearGradient(colors: [
                                   .white.opacity(0),
                                   .white.opacity(0.5),
                                   .white.opacity(0.15),
                                   .white.opacity(0.25),
                                   .white,
                                   .white
                                  ],
                          startPoint: .leading,
                          endPoint: .trailing),
           style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
 }
}
