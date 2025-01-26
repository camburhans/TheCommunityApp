import UIKit
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import AWSDataStorePlugin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAmplify()
        return true
    }

    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.add(plugin: AWSDataStorePlugin())
            try Amplify.configure()
            print("Amplify configured successfully")
        } catch {
            print("Failed to initialize Amplify: \(error)")
        }
    }
}
