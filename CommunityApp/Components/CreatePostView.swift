//
//  CreatePostView 2.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 1/25/25.
//


import SwiftUI

struct CreatePostView: View {
    @State private var description: String = ""
    @State private var selectedImage: UIImage?
    @State private var isPickerPresented: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var successMessage: String?

    var body: some View {
        VStack {
            // Description input
            TextField("Enter description", text: $description)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Image preview
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            } else {
                // Show a placeholder if no image is selected
                Image("post1") // Image from Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
            }
            
            // Select image button
            Button(action: {
                isPickerPresented = true
            }) {
                Text("Select Image")
            }
            .padding()
            
            // Create post button
            Button(action: createPost) {
                Text("Create Post")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading || description.isEmpty)
            .padding()
            
            // Show progress or messages
            if isLoading {
                ProgressView("Uploading...")
            }
            if let message = errorMessage {
                Text("Error: \(message)")
                    .foregroundColor(.red)
            }
            if let message = successMessage {
                Text(message)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(image: $selectedImage)
        }
    }

    private func createPost() {
        // Use placeholder image if none selected
        let imageToUpload = selectedImage ?? UIImage(named: "post1")
        
        guard let image = imageToUpload else {
            errorMessage = "No image available for upload."
            return
        }
        
        isLoading = true
        errorMessage = nil
        successMessage = nil
        
        // Upload image
        AWSManager.shared.uploadImage(image: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageURL):
                    // Create post
                    let newPost = Post(id: UUID().uuidString, description: description, imageURL: imageURL)
                    AWSManager.shared.createPost(post: newPost) { result in
                        isLoading = false
                        switch result {
                        case .success(_):
                            successMessage = "Post created successfully!"
                            description = ""
                            selectedImage = nil
                        case .failure(let error):
                            errorMessage = "Error creating post: \(error.localizedDescription)"
                        }
                    }
                case .failure(let error):
                    isLoading = false
                    errorMessage = "Error uploading image: \(error.localizedDescription)"
                }
            }
        }
    }
}

// Replace `postData` with `Post` struct suitable for Amplify DataStore
struct Post: Identifiable, Codable {
    let id: String
    let description: String
    let imageURL: String
}
