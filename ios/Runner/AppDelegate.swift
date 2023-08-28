import UIKit
import Flutter
import Toast

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let toastController : FlutterViewController = window?.rootViewController as! FlutterViewController
      let messageController : FlutterViewController = window?.rootViewController as! FlutterViewController
      let toastChannelName = FlutterMethodChannel(name: "toast-channel", binaryMessenger: toastController.binaryMessenger)
      let messageChannelName = FlutterMethodChannel(name: "message-channel", binaryMessenger: messageController.binaryMessenger)
      
      toastChannelName.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in guard call.method == "showToast" else{
              result(FlutterMethodNotImplemented)
              return
          }
          if let arguments = call.arguments as? NSDictionary,
             let message = arguments["message"] as? String {
              
              self?.window?.makeToast(message, duration: 2.0, position: .bottom)
//              self?.showToast(message: message)
              result(nil)
          } else {
              result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
          }
      })
      
      
      messageChannelName.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in guard call.method == "getMessageFromNativeCode" else{
              result(FlutterMethodNotImplemented)
              return
          }
          self?.getMessage(result: result)
      })
      
      
      GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func showToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.window?.rootViewController?.present(toast, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            toast.dismiss(animated: true, completion: nil)
        }
    }
    
    private func getMessage(result: FlutterResult){
        let message = "Message from Swift code"
        if(message.isEmpty){
            result(FlutterError(code: "Unavailable", message: "Message from Swift code is empty", details: nil))
        } else {
            result(message)
        }
    }
}
