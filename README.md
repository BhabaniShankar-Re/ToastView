#  ToastView

ToastView show toast message like in android.

To use ToastView you have to configure it in Appdelegate.

``` Swift 
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Toastview.configure()
        
        return true
    }
}
```

To use different color for background for all toast view, you can you use different version of `configure()`.
