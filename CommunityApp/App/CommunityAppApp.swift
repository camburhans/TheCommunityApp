import SwiftUI

@main
struct TheCommunityAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // Add this line
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
