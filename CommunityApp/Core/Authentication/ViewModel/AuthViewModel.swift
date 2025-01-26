import Foundation
import Amplify
import AWSAuthPlugin

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: AuthUser?
    @Published var currentUser: User?

    init() {
        Task {
            await loadCurrentAuthUser()
        }
    }
    
    func loadCurrentAuthUser() async {
        do {
            let currentUser = try await Amplify.Auth.getCurrentUser()
            self.userSession = currentUser
            await fetchUser()
        } catch {
            print("DEBUG: No user is signed in")
            self.userSession = nil
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let signInResult = try await Amplify.Auth.signIn(username: email, password: password)
            if signInResult.isSignedIn {
                await loadCurrentAuthUser()
            }
        } catch {
            print("DEBUG: Sign in failed with error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let signUpResult = try await Amplify.Auth.signUp(username: email, password: password, options: .init(userAttributes: [AuthUserAttribute(.email, value: email)]))
            if signUpResult.isSignUpComplete {
                try await signIn(withEmail: email, password: password)
                let user = User(id: userSession?.userId ?? "", fullname: fullname, email: email)
                try await Amplify.DataStore.save(user)
                await loadCurrentAuthUser()
            }
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        Task {
            do {
                try await Amplify.Auth.signOut()
                self.userSession = nil
                self.currentUser = nil
            } catch {
                print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            }
        }
    }
    
    func deleteAccount() {
        // Implement account deletion logic if needed
    }
    
    func fetchUser() async {
        guard let userId = userSession?.userId else { return }
        do {
            if let user = try await Amplify.DataStore.query(User.self, byId: userId) {
                self.currentUser = user
            }
        } catch {
            print("DEBUG: Failed to fetch user with error \(error.localizedDescription)")
        }
    }
}

// Define the User struct to match your existing model, ensuring it's Codable and conforms to Identifiable for DataStore
struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
}
