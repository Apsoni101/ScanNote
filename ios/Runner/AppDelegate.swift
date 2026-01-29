import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var widgetUrl: String?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {


        GeneratedPluginRegistrant.register(with: self)

        setupMethodChannel()

        if let url = launchOptions?[.url] as? URL {
            widgetUrl = url.absoluteString
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        widgetUrl = url.absoluteString

        return true
    }

    private func setupMethodChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else {
            return
        }

        let channel = FlutterMethodChannel(
            name: "com.scannote.app/widget",
            binaryMessenger: controller.binaryMessenger
        )

        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else {
                result(FlutterError(code: "UNAVAILABLE", message: "Self is nil", details: nil))
                return
            }

            switch call.method {
            case "getWidgetUrl":
                result(self.widgetUrl)

            case "clearWidgetUrl":
                self.widgetUrl = nil
                result(nil)

            default:
                result(FlutterMethodNotImplemented)
            }
        }

    }
}