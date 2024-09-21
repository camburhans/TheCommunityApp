//
//  CreatePostView.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/21/24.
//

import SwiftUI

import SwiftUI

struct CreatePostView: View {
    @State private var description: String = ""
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            TextField("Enter description", text: $description)
                .padding()
            
            Button(action: {
                if let image = selectedImage {
                    FirebaseStorageManager().uploadImage(image) { result in
                        switch result {
                        case .success(let imageURL):
                            let newPost = postData(imageURL: imageURL, like_count: 0, comment_count: 0, view_count: 0, description: description, profile_img: "default", profile_name: "User", profile_id: "user_id")
                            FirebaseManager.shared.createPost(post: newPost) { error in
                                if let error = error {
                                    print("Error creating post: \(error)")
                                } else {
                                    print("Post created successfully!")
                                }
                            }
                        case .failure(let error):
                            print("Error uploading image: \(error)")
                        }
                    }
                }
            }) {
                Text("Create Post")
            }
        }
    }
}


#Preview {
    CreatePostView()
}
