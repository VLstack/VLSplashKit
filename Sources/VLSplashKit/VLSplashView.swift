import SwiftUI

// create a new package and use at dependencies:

/// Returns the result of recomputing the view's body with the provided
/// animation according to “Reduce Motion” accessibility setting.
///
/// Source: [HackingWithSwift](https://www.hackingwithswift.com/quick-start/swiftui/how-to-reduce-animations-when-requested)
///
/// This function sets the given `Animation` as the `Transaction/animation`
/// property of the thread's current `Transaction`
/// if "Reduce Motion" setting is "on" this function returns the provided View body
internal
func withAccesibilityAnimation<Result>(_ animation: Animation? = .default,
                                       _ body: () throws -> Result) rethrows -> Result
{
// if UIAccessibility.isReduceMotionEnabled { return try body() }

 return try withAnimation(animation, body)
}

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
 init(@ViewBuilder content: @escaping () -> Content)
 {
  self.content = content()
 }
 
 // MARK: - Private
 private func delay(_ duration: CGFloat, _ animation: Animation, callback: @escaping () -> Void )
 {
  DispatchQueue.main.asyncAfter(deadline: .now() + duration)
  {
   withAccesibilityAnimation(animation)
   {
    callback()
   }
  }
 }

 private func onAppear()
 {
//  delay(0.5, .easeInOut(duration: 1)) { hideLogoVLstack.toggle() }
  delay(0.25, .linear(duration: 1)) { animateTrailingLine.toggle() }
  delay(0.5, .linear(duration: 1)) { animateLeadingLine.toggle() }
  delay(1.5, .linear(duration: 1)) { isCompleted.toggle() }
 }
 
 // MARK: - Public
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
     .fill(.white)
     .ignoresSafeArea()
    
    Image(.vLstackLogo)
     .resizable()
     .renderingMode(.template)
     .aspectRatio(contentMode: .fit)
     .foregroundColor(.white)
     .frame(width: logoApp,
            height: logoApp)
    
    Group
    {
     VLBrandSplashLineView(size: logoApp,
                           animateLeading: animateLeadingLine,
                           animateTrailing: animateTrailingLine)
     VLBrandSplashLineView(size: logoApp,
                           animateLeading: animateLeadingLine,
                           animateTrailing: animateTrailingLine)
     .rotationEffect(.init(degrees: 180))
    }
    .frame(maxWidth: .infinity)
    .frame(height: logoApp)
   }
   .overlay(alignment: .bottomTrailing)
   {
    Image(.vLstackLogo)
     .resizable()
     .renderingMode(.template)
     .aspectRatio(contentMode: .fit)
     .foregroundColor(.white)
     .frame(width: logoVLstack,
            height: logoVLstack)
     .padding()
   }
   .onAppear(perform: onAppear)
  }
 }
}

#Preview
{
 VLBrandSplashView
 {
  Text("xx")
 }
}
