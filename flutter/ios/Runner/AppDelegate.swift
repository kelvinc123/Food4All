import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Add Yiyu's google maps API key
    GMSServices.provideAPIKey("AIzaSyC61gSzPOGgTJfJHLPE3LiJR3VH9ozarvk")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
