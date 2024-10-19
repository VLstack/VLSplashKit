import VLstackNamespace
import VLBrandKit
import SwiftUI

public extension VLstack
{
 internal struct SplashAnimationValues
 {
  var lineLeadingTrim: CGFloat = 0
  var lineTrailingTrim: CGFloat = 0
  var scaleVLstack: CGFloat = 1
  var scaleAppLogo: CGFloat = 0
  var opacityAppLogo: CGFloat = 0
 }

 struct SplashView<Source: View, Content: View>: View
 {
  @Environment(\.splashType) private var splashType

  private let content: () -> Content
  private let source: Source
  private let isImage: Bool
  private let isTemplate: Bool
  private let width: CGFloat
  private let height: CGFloat
  private let size: CGFloat = min(128, max(64, UIScreen.main.bounds.width * 0.3))

  @State private var animationStarted: Bool = false
  @State private var animationComplete: Bool = false

  public init(width: CGFloat? = nil,
              height: CGFloat? = nil,
              @ViewBuilder view: @escaping () -> Source,
              @ViewBuilder content: @escaping () -> Content)
  {
   self.content = content
   self.source = view()
   self.isImage = false
   self.isTemplate = false
   self.width = width ?? size
   self.height = height ?? size
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

  public var body: some View
  {
   if animationComplete
   {
    content()
   }
   else
   {
    KeyframeAnimator(initialValue: SplashAnimationValues(),
                     trigger: animationStarted)
    {
     values in
     ZStack
     {
      switch splashType
      {
       case .brandBackground: VLstack.SplashBackgroundBrand()
       case .linearGradient(let color): VLstack.SplashBackgroundLinear(color: color,
                                                                       delay: 1.5,
                                                                       duration: 2.5)
      }

      VLstack.Brand.logo
       .resizable()
       .renderingMode(.template)
       .aspectRatio(contentMode: .fit)
       .foregroundStyle(VLstack.Brand.Color.primary500On)
       .scaleEffect(values.scaleVLstack)
       .frame(width: size, height: size)

      logoView
       .scaleEffect(values.scaleAppLogo)
       .opacity(values.opacityAppLogo)

      Group
      {
       VLstack.SplashLineView(size: size,
                              leadingTrim: values.lineLeadingTrim,
                              trailingTrim: values.lineTrailingTrim)
       VLstack.SplashLineView(size: size,
                              leadingTrim: values.lineLeadingTrim,
                              trailingTrim: values.lineTrailingTrim)
       .rotationEffect(.init(degrees: 180))
      }
      .frame(maxWidth: .infinity)
      .frame(height: size)
     }
    }
    keyframes:
    {
     _ in

     KeyframeTrack(\.lineLeadingTrim)
     {
      LinearKeyframe(0, duration: 0.25)
      LinearKeyframe(1, duration: 1.75)
     }

     KeyframeTrack(\.lineTrailingTrim)
     {
      LinearKeyframe(1, duration: 1)
     }

     KeyframeTrack(\.scaleVLstack)
     {
      LinearKeyframe(1, duration: 1)
      LinearKeyframe(0, duration: 0.5)
     }

     KeyframeTrack(\.scaleAppLogo)
     {
      LinearKeyframe(0, duration: 1)
      LinearKeyframe(1, duration: 0.5)
     }

     KeyframeTrack(\.opacityAppLogo)
     {
      LinearKeyframe(0, duration: 1)
      LinearKeyframe(1, duration: 0.5)
      LinearKeyframe(1, duration: 1)
      LinearKeyframe(0, duration: 0.5)
     }
    }
    .onAppear
    {
     animationStarted = true
     DispatchQueue.main.asyncAfter(deadline: .now() + 3.25)
     {
      animationComplete = true
     }
    }
   }
  }

  @ViewBuilder
  private var logoView: some View
  {
   if isImage
   {
    (source as! Image)
     .resizable()
     .renderingMode(isTemplate ? .template : .original)
     .aspectRatio(contentMode: .fit)
     .frame(width: width, height: height)
     .foregroundStyle(VLstack.Brand.Color.primary500On)
   }
   else
   {
    source
     .frame(width: width, height: height)
   }
  }
 }
}

#if DEBUG
#Preview
{
 VLstack.SplashView { Image(systemName: "figure.american.football").foregroundStyle(.yellow).font(.system(size: 80)) }
           content: { Text("splash is complete") }
  .splashType(.linearGradient(.red))
}

#Preview
{
 VLstack.SplashView { Text("Source").foregroundStyle(.red) }
           content: { Text("complete") }
}

#Preview
{
 VLstack.SplashView(image: Image(systemName: "figure.american.football"),
                    width: 400,
                    height: 400)
 {
  Text("completed")
 }
}

#Preview
{
 VLstack.SplashView(template: Image(systemName: "figure.american.football"))
 {
  Text("completed")
 }
}
#endif
