import VLstackNamespace
import SwiftUI

extension VLstack
{
 internal struct SplashBackgroundBrand: View
 {
  var body: some View
  {
   Rectangle()
    .fill(VLstack.Brand.Color.primary500)
    .ignoresSafeArea()
  }
 }
}
