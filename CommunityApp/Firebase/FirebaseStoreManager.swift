//
//  FirebaseStoreManager.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/21/24.
//

import Foundation
import FirebaseStorage
import UIKit

class FirebaseStorageManager {
    private let storage = Storage.storage()

    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let imageName = UUID().uuidString
        let storageRef = storage.reference().child("images/\(imageName).jpg")
        
        // Ensure the UIImage can be converted to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Error: Failed to convert UIImage to JPEG data")
            completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert UIImage to JPEG data."])))
            return
        }
        
        print("Uploading image of size: \(imageData.count) bytes")

        // Upload the image data to Firebase Storage
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Upload failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Image uploaded successfully. Fetching download URL...")
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Failed to fetch download URL: \(error.localizedDescription)")
                        completion(.failure(error))
                    } else if let url = url {
                        print("Image uploaded successfully. URL: \(url.absoluteString)")
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }
}

