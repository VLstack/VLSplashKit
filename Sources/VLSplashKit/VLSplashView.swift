import SwiftUI
import VLBrandKit
import VLUtilsKit

public
struct VLSplashView<Content: View>: View
{
 // MARK: Parameters
 let content: Content
 let image: Image
 
 // MARK: - Constants
 let logoSize: CGFloat = 85
 
 // MARK: - States
 @State private var isFinished: Bool = false
 @State private var hideLogoVLstack: Bool = false
 @State private var showLogoApplication: Bool = false
 @State private var hideLogoApplication: Bool = false
 @State private var animateLeadingLine: Bool = false
 @State private var animateTrailingLine: Bool = false
 
 // MARK: - Constructor
 public
 init(image: Image,
      @ViewBuilder content: @escaping () -> Content)
 {
  self.image = image
  self.content = content()
 }
 
 private
 func onAppear()
 {
  VLUtils.delay(0.25, animation: .linear(duration: 1)) { animateTrailingLine.toggle() }
  VLUtils.delay(0.5, animation: .linear(duration: 1)) { animateLeadingLine.toggle() }
  VLUtils.delay(1, animation: .linear(duration: 0.25)) { hideLogoVLstack.toggle() }
  VLUtils.delay(1, animation: .linear(duration: 0.5)) { showLogoApplication.toggle() }
  VLUtils.delay(2.5, animation: .linear(duration: 0.25)) { hideLogoApplication.toggle() }
  VLUtils.delay(3, animation: .linear(duration: 0.25)) { isFinished.toggle() }
 }
 
 // MARK: - Public
 public
 var body: some View
 {
  if isFinished
  {
   content
  }
  else
  {
   ZStack
   {
     Rectangle()
      .fill(VLBrandKit.Colors.primary500)
      .ignoresSafeArea()
      
     VLBrandKit.Images.logo
      .resizable()
      .renderingMode(.template)
      .aspectRatio(contentMode: .fit)
      .foregroundColor(VLBrandKit.Colors.primary500On)
      .scaleEffect(hideLogoVLstack ? 0 : 1)
      .frame(width: logoSize, height: logoSize)

      self.image
      .resizable()
      .renderingMode(.template)
      .aspectRatio(contentMode: .fit)
      .foregroundColor(VLBrandKit.Colors.primary500On)
      .scaleEffect(hideLogoApplication ? 100 : 1)
      .frame(width: logoSize, height: logoSize)
      .opacity(showLogoApplication ? 1 : 0)
        
     Group
     {
      VLSplashLineView(size: logoSize,
                       animateLeading: animateLeadingLine,
                       animateTrailing: animateTrailingLine)
      VLSplashLineView(size: logoSize,
                       animateLeading: animateLeadingLine,
                       animateTrailing: animateTrailingLine)
      .rotationEffect(.init(degrees: 180))
     }
     .frame(maxWidth: .infinity)
     .frame(height: logoSize)
    }
   
   .onAppear(perform: onAppear)
  }
 }
}

#if DEBUG
#Preview
{
 VLSplashView(image: Image(systemName: "figure.american.football"))
 {
  Text("splash is complete")
 }
}
#endif
