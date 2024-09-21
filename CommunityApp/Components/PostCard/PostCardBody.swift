//
//  PostCardBody.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 9/2/24.
//

import SwiftUI

struct PostCardBody: View {
    
    let image: String
    let like_count: Int
    let comment_count: Int
    let view_count: Int
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text(description)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.callout)
                .foregroundColor(.black)
            
            if !image.isEmpty {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .roundedCorner(10, corners: [.bottomLeft, .topRight, .bottomRight])
            }
            
            HStack(spacing: 20) {
                HStack(spacing: 3) {
                    Image(systemName: "heart")
                    Text("\(like_count.formattedString())")
                }
                HStack(spacing: 3) {
                    Image(systemName: "text.bubble")
                    Text("\(comment_count.formattedString())")
                }
                Spacer()
            }
            .font(.callout)
        }
        .padding(.leading, 48)
    }
}

#Preview {
    PostCardBody(image: "post1", like_count: 200, comment_count: 21, view_count: 31, description: "test")
}
