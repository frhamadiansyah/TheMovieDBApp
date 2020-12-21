//
//  URLImageView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import SwiftUI

struct URLImageView: View {
    @ObservedObject var imageLoader : ImageLoader
    
    init(urlString: String?) {
        imageLoader = ImageLoader(urlString: urlString)

    }
    
//    @State private var isAnimating = false
//    var foreverAnimation: Animation {
//        Animation.linear(duration: 2.0)
//            .repeatForever(autoreverses: false)
//    }
    
    let width = UIScreen.main.bounds.width * 0.4
    
    
    var body: some View {
        HStack {
            //            Spacer()
            if imageLoader.image == nil {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
//                Image(systemName: "arrow.2.circlepath")
//                    .resizable()
//                    .scaledToFit()
//                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
//                    .animation(foreverAnimation)
//                    .onAppear { self.isAnimating = true }
            } else {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFit()
                    
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.4)
    }
    
    
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}

