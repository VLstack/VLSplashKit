import VLstackNamespace
import SwiftUI

extension VLstack
{
 internal struct SplashLineView: View
 {
  var size: CGFloat
  var leadingTrim: CGFloat
  var trailingTrim: CGFloat

  var body: some View
  {
   VLstack.SplashLineShape(size: size)
    .trim(from: leadingTrim,
          to: trailingTrim)
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
            style: StrokeStyle(lineWidth: 10,
                               lineCap: .round,
                               lineJoin: .round))
  }
 }
}
