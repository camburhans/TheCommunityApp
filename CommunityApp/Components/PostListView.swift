//
//  PostListView.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/2/24.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var postData = ReadJsonData() // Observed object for reading JSON data
    
    var body: some View {
        VStack {
            ForEach(postData.posts) { post in // Iterate over each post in the data
                PostCard(
                    profile_img: post.profile_img,
                    profile_name: post.profile_name,
                    profile_id: post.profile_id,
                    image: post.image,
                    like_count: post.like_count,
                    comment_count: post.comment_count,
                    view_count: post.view_count,
                    description: post.description
                )
                .padding(.top)
            }
            
        }
        .listStyle(.plain) // Set the list style to plain
        .padding() // Apply padding to the VStack
    }
}

#Preview {
    PostListView()
}
