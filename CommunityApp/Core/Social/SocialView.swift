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
//                StoryListView() // Display the list of stories
                PostListView() // Display the list of posts
            }
            .navigationTitle("CommunityApp") // Set the navigation title
            .navigationBarItems(leading: Image(systemName: "pencil.and.outline"), trailing: Image(systemName: "bell.badge.fill")) // Add leading and trailing navigation bar items
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
