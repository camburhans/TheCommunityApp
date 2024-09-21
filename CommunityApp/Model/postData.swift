//
//  postData.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/21/24.
//

import Foundation

struct postData: Identifiable, Codable {
    var id: String = UUID().uuidString // Unique ID for each post
    var imageURL: String // URL from Firebase Storage
    var like_count: Int
    var comment_count: Int
    var view_count: Int
    var description: String
    var profile_img: String
    var profile_name: String
    var profile_id: String
}
