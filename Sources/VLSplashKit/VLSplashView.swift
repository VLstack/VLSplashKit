import SwiftUI
import VLBrandKit
import VLUtilsKit
import VLstackNamespace

public struct VLSplashView<Source: View, Content: View>: View
{
 // MARK: Parameters
 private let content: () -> Content
 private let source: Source
 private let isImage: Bool
 private let isTemplate: Bool
 private let width: CGFloat
 private let height: CGFloat
 
 // MARK: - Constants
 private let size: CGFloat = 85
 
 // MARK: - States
 @State private var isFinished: Bool = false
 @State private var hideLogoVLstack: Bool = false
 @State private var showLogoApplication: Bool = false
 @State private var hideLogoApplication: Bool = false
 @State private var animateLeadingLine: Bool = false
 @State private var animateTrailingLine: Bool = false
 
 // MARK: - Constructor
 public init(@ViewBuilder view: @escaping () -> Source,
             @ViewBuilder content: @escaping () -> Content)
 {
  self.content = content
  self.source = view()
  self.isImage = false
  self.isTemplate = false
  self.width = size
  self.height = size
 }
 
 public init(image: Image,
             width: CGFloat? = nil,
             height: CGFloat? = nil,
             @ViewBuilder content: @escaping () -> Content) where Source == Image
 {
  self.content = content
  self.source = image
  self.isImage = true
  self.isTemplate = false
  self.width = width ?? size
  self.height = height ?? size
 }
 
 public init(template: Image,
             @ViewBuilder content: @escaping () -> Content) where Source == Image
 {
  self.content = content
  self.source = template
  self.isImage = true
  self.isTemplate = true
  self.width = size
  self.height = size
 }
  
 private func onAppear()
 {
  VLUtils.delay(0.25, animation: .linear(duration: 1)) { animateTrailingLine.toggle() }
  VLUtils.delay(0.5, animation: .linear(duration: 1)) { animateLeadingLine.toggle() }
  VLUtils.delay(1, animation: .linear(duration: 0.25)) { hideLogoVLstack.toggle() }
  VLUtils.delay(1, animation: .linear(duration: 0.5)) { showLogoApplication.toggle() }
  VLUtils.delay(2.5, animation: .linear(duration: 0.25)) { hideLogoApplication.toggle() }
  VLUtils.delay(3) { isFinished.toggle() }
 }
 
 // MARK: - Public
 public var body: some View
 {
  if isFinished
  {
   content()
  }
  else
  {
   ZStack
   {
    Rectangle()
     .fill(VLBrandKit.Colors.primary500)
     .ignoresSafeArea()
     
    VLstack.Brand.Logo.template
     .resizable()
     .renderingMode(.template)
     .aspectRatio(contentMode: .fit)
     .foregroundColor(VLBrandKit.Colors.primary500On)
     .scaleEffect(hideLogoVLstack ? 0 : 1)
     .frame(width: size, height: size)

     logoView
     .background(hideLogoApplication ? VLBrandKit.Colors.primary500On : Color.clear)
     .scaleEffect(hideLogoApplication ? 0 : 1)
     .opacity(showLogoApplication ? 1 : 0)
        
     Group
     {
      VLSplashLineView(size: size,
                       animateLeading: animateLeadingLine,
                       animateTrailing: animateTrailingLine)
      VLSplashLineView(size: size,
                       animateLeading: animateLeadingLine,
                       animateTrailing: animateTrailingLine)
      .rotationEffect(.init(degrees: 180))
     }
     .frame(maxWidth: .infinity)
     .frame(height: size)
    }
   
   .onAppear(perform: onAppear)
  }
 }
 
 @ViewBuilder
 private var logoView: some View
 {
  if isImage
  {
   (source as! Image).resizable()
         .renderingMode(isTemplate ? .template : .original)
         .aspectRatio(contentMode: .fit)
         .frame(width: width, height: height)
         .foregroundStyle(VLBrandKit.Colors.primary500On)
  }
  else
  {
   source
  }
 }
}

#if DEBUG
#Preview
{
 VLSplashView { Image(systemName: "figure.american.football").foregroundStyle(.yellow) }
 content: { Text("splash is complete") }
}

#Preview
{
 VLSplashView { Text("Source").foregroundStyle(.red) }
     content: { Text("complete") }
}

#Preview
{
 VLSplashView(image: Image(systemName: "figure.american.football"),
              width: 400,
              height: 400)
 {
  Text("completed")
 }
}

#Preview
{
 VLSplashView(template: Image(systemName: "figure.american.football"))
 {
  Text("completed")
 }
}
#endif
