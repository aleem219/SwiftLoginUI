//
//  UserImageView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

// UserImageView.swift

import SwiftUI

struct UserImageView: View {
    
    let imageUrl: String?
    let imageName: String
    var width: CGFloat = 120
    var height: CGFloat = 120
    
    private let folderName = "user_images"
    
    var body: some View {
        if let cachedImage = LocalFileManager.instance.getImage(imageName: imageName, folderName: folderName) {
            Image(uiImage: cachedImage)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.theme.backGround, lineWidth: 2)
                }
        } else {
            AsyncImage(url: URL(string: imageUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: width, height: height) // ✅ was hardcoded 100
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height) // ✅ was hardcoded 100
                        .clipped()                           // ✅ clip overflow
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.theme.backGround, lineWidth: 1)
                        }
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: width, height: height) // ✅ was hardcoded 100
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    UserImageView(imageUrl: "https://dummyjson.com/icon/emmajohnson/128", imageName: "1")
}
