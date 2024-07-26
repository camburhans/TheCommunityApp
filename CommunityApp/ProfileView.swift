import SwiftUI
import GoogleSignIn

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .padding()

                GoogleSignInButton()

                // Add more UI elements here as needed
            }
            .navigationTitle("Profile")
            .background(Color.white)
        }
    }
}

struct GoogleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.signIn), for: .touchUpInside)
        return button
    }

    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        @objc func signIn() {
            guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else { return }
            let config = GIDConfiguration(clientID: clientID)
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                return
            }
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                guard let signInResult = signInResult else {
                    print("No sign-in result")
                    return
                }

                let user = signInResult.user
                let emailAddress = user.profile?.email
                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName
                let profilePicUrl = user.profile?.imageURL(withDimension: 320)

                // Handle sign-in success
                print("User signed in: \(fullName ?? "No name")")
                print("Email: \(emailAddress ?? "No email")")
                if let profilePicUrl = profilePicUrl {
                    print("Profile Picture URL: \(profilePicUrl)")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
