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
