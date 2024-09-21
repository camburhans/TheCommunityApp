//
//  FirebaseManager.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/21/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    // Upload post data to Firestore
    func createPost(post: postData, completion: @escaping (Error?) -> Void) {
        let postRef = db.collection("posts").document() // Creates a unique document in "posts" collection
        do {
            try postRef.setData(from: post) { error in
                completion(error)
            }
        } catch let error {
            completion(error)
        }
    }

    // Upload image to Firebase Storage and get the URL
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let imageName = UUID().uuidString
        let storageRef = storage.reference().child("images/\(imageName).jpg")
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    storageRef.downloadURL { url, error in
                        if let error = error {
                            completion(.failure(error))
                        } else if let url = url {
                            completion(.success(url.absoluteString))
                        }
                    }
                }
            }
        }
    }
}
