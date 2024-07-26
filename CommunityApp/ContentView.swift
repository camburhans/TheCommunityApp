import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1 // Default to Social tab (index 1)

    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0) // Tag 0 for Calendar tab

            SocialView()
                .tabItem {
                    Label("Social", systemImage: "person.3")
                }
                .tag(1) // Tag 1 for Social tab

            AnnouncementsView()
                .tabItem {
                    Label("Announcements", systemImage: "megaphone")
                }
                .tag(2) // Tag 2 for Announcements tab

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(3) // Tag 3 for Profile tab
        }
        .onAppear {
            // Set the initial selected tab
            selectedTab = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
