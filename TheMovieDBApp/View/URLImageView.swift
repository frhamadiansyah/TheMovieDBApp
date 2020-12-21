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
    
    let width = UIScreen.main.bounds.width * 0.4
    
    
    var body: some View {
        HStack {
            if imageLoader.image == nil {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
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

