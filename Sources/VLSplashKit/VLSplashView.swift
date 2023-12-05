import SwiftUI
import VLBrandKit
import VLUtilsKit

public
struct VLSplashView<Content: View>: View
{
 // MARK: Parameters
 let content: Content
 
 // MARK: - Constants
 let logoApp: CGFloat = 85
 let logoVLstack: CGFloat = 65
 
 // MARK: - States
 @State private var isCompleted: Bool = false
 @State private var hideLogoVLstack: Bool = false
 @State private var animateLogoApplication: Bool = false
 @State private var animateLeadingLine: Bool = false
 @State private var animateTrailingLine: Bool = false

 // MARK: - Constructor
 public
 init(@ViewBuilder content: @escaping () -> Content)
 {
  self.content = content()
 }
 
 // MARK: - Private
 private 
 func delayAnimation(_ duration: CGFloat,
                     _ animation: Animation,
                     callback: @escaping () -> Void )
 {
  DispatchQueue.main.asyncAfter(deadline: .now() + duration)
  {
   VLUtils.animate(animation)
   {
    callback()
   }
  }
 }

 private 
 func onAppear()
 {
//  delayAnimation(0.5, .easeInOut(duration: 1)) { hideLogoVLstack.toggle() }
  delayAnimation(0.25, .linear(duration: 1)) { animateTrailingLine.toggle() }
  delayAnimation(0.5, .linear(duration: 1)) { animateLeadingLine.toggle() }
  delayAnimation(1.5, .linear(duration: 1)) { isCompleted.toggle() }
 }
 
 // MARK: - Public
 public
 var body: some View
 {
  if isCompleted
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
     .frame(width: logoApp,
            height: logoApp)
       
    Group
    {
     VLSplashLineView(size: logoApp,
                      animateLeading: animateLeadingLine,
                      animateTrailing: animateTrailingLine)
     VLSplashLineView(size: logoApp,
                      animateLeading: animateLeadingLine,
                      animateTrailing: animateTrailingLine)
     .rotationEffect(.init(degrees: 180))
    }
    .frame(maxWidth: .infinity)
    .frame(height: logoApp)
   }
   .onAppear(perform: onAppear)
  }
 }
}

#if DEBUG
#Preview
{
 VLSplashView
 {
  Text("splash is complete")
 }
}
#endif
