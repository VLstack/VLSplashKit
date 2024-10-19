import VLstackNamespace
import SwiftUI

extension VLstack
{
 internal struct SplashBackgroundLinear: View
 {
  var color: Color
  var delay: TimeInterval
  var duration: TimeInterval

  @State private var animateStart: Bool = false
  @State private var animateEnd: Bool = false

  var body: some View
  {
   Rectangle()
   .fill(LinearGradient(colors: [
                                 animateStart ? color : VLstack.Brand.Color.primary500,
                                 animateEnd ? color : VLstack.Brand.Color.primary500
                                ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
   .ignoresSafeArea()
   .animation(.linear(duration: duration).delay(delay).repeatCount(1, autoreverses: false),
              value: animateStart)
   .animation(.linear(duration: delay).delay(duration).repeatCount(1, autoreverses: false),
              value: animateEnd)
   .onAppear
   {
    withAnimation
    {
     animateStart.toggle()
     animateEnd.toggle()
    }
   }
  }
 }
}
