import VLstackNamespace
import SwiftUI

// IOS18
//public extension EnvironmentValues
//{
// @Entry var splashType: VLstack.SplashType = .brandBackground
//}

struct VLSplashTypeKey: EnvironmentKey
{
 public static let defaultValue: VLstack.SplashType = .brandBackground
}

extension EnvironmentValues
{
 public var splashType: VLstack.SplashType
 {
  get { self[VLSplashTypeKey.self] }
  set { self[VLSplashTypeKey.self] = newValue }
  }
}

public extension View
{
 func splashType(_ type: VLstack.SplashType) -> some View
 {
  self.environment(\.splashType, type)
 }
}
