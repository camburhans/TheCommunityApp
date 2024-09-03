//
//  PostCard.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/2/24.
//

import SwiftUI

struct PostCard: View {
    // Properties for the post card
    let profile_img: String
    let profile_name: String
    let profile_id: String
    
    let image: String
    let like_count: Int
    let comment_count: Int
    let view_count: Int
    let description: String
    
    var body: some View {
        VStack {
            PostCardHeader(profile_img: profile_img, profile_name: profile_name, profile_id: profile_id)
            // Display the header section of the post card, including profile image, name, and ID
            
            PostCardBody(image: image, like_count: like_count, comment_count: comment_count, view_count: view_count, description: description)
            // Display the body section of the post card, including image, counts, and description
        }
    }
}

#Preview {
    PostCard(profile_img: "bear", profile_name: "Cam Test", profile_id: "camtest", image: "post1", like_count: 321, comment_count: 21, view_count: 333, description: "This is a test description")
}
