//
//  SettingsRowView.swift
//  CommunityApp
//
//  Created by Cameron Burhans on 7/27/24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(Color(tintColor))
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color(.black))
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
