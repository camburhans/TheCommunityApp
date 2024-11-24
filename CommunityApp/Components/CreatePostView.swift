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
        FirebaseStorageManager().uploadImage(image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageURL):
                    // Create post
                    let newPost = postData(
                        imageURL: imageURL,
                        like_count: 0,
                        comment_count: 0,
                        view_count: 0,
                        description: description,
                        profile_img: "default",
                        profile_name: "User",
                        profile_id: "user_id"
                    )
                    FirebaseManager.shared.createPost(post: newPost) { error in
                        isLoading = false
                        if let error = error {
                            errorMessage = "Error creating post: \(error.localizedDescription)"
                        } else {
                            successMessage = "Post created successfully!"
                            description = ""
                            selectedImage = nil
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



// ImagePicker Component
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let uiImage = info[.editedImage] as? UIImage {
                parent.image = uiImage
            } else if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    CreatePostView()
}
