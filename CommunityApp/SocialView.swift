import SwiftUI

struct SocialView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Social")
                    .font(.largeTitle)
                    .padding()
                // Add more UI elements here as needed
            }
            .navigationTitle("Social")
            .background(Color.white)
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
