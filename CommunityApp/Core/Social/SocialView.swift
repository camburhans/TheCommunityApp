//
//  SocialView.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 8/31/24.
//

import SwiftUI

struct SocialView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                // StoryListView() // Uncomment if you have a StoryListView
                PostListView() // Display the list of posts
            }
            .navigationTitle("CommunityApp") // Set the navigation title
            .navigationBarItems(
                leading: NavigationLink(destination: CreatePostView()) {
                    Image(systemName: "pencil.and.outline") // CreatePostView will open on tap
                },
                trailing: Image(systemName: "bell.badge.fill") // You can add functionality to this too
            ) // Add leading and trailing navigation bar items
        }
    }
}


struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
