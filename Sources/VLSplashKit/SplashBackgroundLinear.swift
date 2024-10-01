import VLstackNamespace
import VLUtilsKit
import SwiftUI

extension VLstack
{
 struct SplashBackgroundLinear: View
 {
  private let color: Color
  @State private var animateStart: Bool = false
  @State private var animateEnd: Bool = false

  init(color: Color)
  {
   self.color = color
  }

  var body: some View
  {
   Rectangle()
    .fill(LinearGradient(colors: [
                                  animateStart ? color : VLstack.Brand.Color.primary500,
                                  animateEnd ? color : VLstack.Brand.Color.primary500
                                 ],
                         startPoint: .topLeading, endPoint: .bottomTrailing))
    .ignoresSafeArea()
    .onAppear
    {
     VLUtils.delay(1, animation: .linear(duration: 2)) { animateStart.toggle() }
     VLUtils.delay(2, animation: .linear(duration: 1)) { animateEnd.toggle() }
    }
  }
 }
}

#Preview
{
 VLstack.SplashBackgroundLinear(color: .red)
}
