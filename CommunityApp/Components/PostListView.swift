//
//  PostListView.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/2/24.
//

import SwiftUI
import FirebaseFirestore

struct PostListView: View {
    @State private var posts: [postData] = [] // State to store fetched posts from Firebase
    
    var body: some View {
        VStack {
            ForEach(posts, id: \.profile_id) { post in
                PostCard(
                    profile_img: post.profile_img,
                    profile_name: post.profile_name,
                    profile_id: post.profile_id,
                    image: post.imageURL,
                    like_count: post.like_count,
                    comment_count: post.comment_count,
                    view_count: post.view_count,
                    description: post.description
                )
                .padding(.top)
            }
        }
        .listStyle(.plain)
        .padding()
        .onAppear {
            fetchPostsFromFirebase() // Fetch posts when the view appears
        }
    }
    
    // Function to fetch posts from Firebase Firestore
    private func fetchPostsFromFirebase() {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error)")
            } else if let snapshot = snapshot {
                self.posts = snapshot.documents.compactMap { document in
                    try? document.data(as: postData.self)
                }
            }
        }
    }
}

#Preview {
    PostListView()
}

