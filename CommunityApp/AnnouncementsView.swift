import SwiftUI

struct AnnouncementsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Announcements")
                    .font(.largeTitle)
                    .padding()
                // Add more UI elements here as needed
            }
            .navigationTitle("Announcements")
            .background(Color.white)
        }
    }
}

struct AnnouncementsView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementsView()
    }
}
