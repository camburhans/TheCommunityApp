//
//  FirebaseManager.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/21/24.
//

import Foundation
import Amplify
import AWSS3StoragePlugin
import AWSDataStorePlugin

class AWSManager {
    static let shared = AWSManager()
    
    // Create a new post
    func createPost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        Amplify.DataStore.save(post) { result in
            switch result {
            case .success(let savedPost):
                completion(.success(savedPost))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Upload image to S3 and get the URL
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let imageKey = UUID().uuidString + ".jpg"
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert UIImage to JPEG data."])))
            return
        }
        
        Amplify.Storage.uploadData(key: imageKey, data: imageData) { result in
            switch result {
            case .success(let key):
                completion(.success(key))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
