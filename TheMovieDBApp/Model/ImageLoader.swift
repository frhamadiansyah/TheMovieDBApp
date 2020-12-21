//
//  ImageLoader.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    
    @Published var image : UIImage?
    var urlString : String?
    private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        guard let url = URL(string: baseImageURL + urlString!) else { return }
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let sessionTask = urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil {
                
                guard let safeData = data else {return}
                
                DispatchQueue.main.async {
                    guard let loadedImage = UIImage(data: safeData) else { return }
                    self.image = loadedImage
                }
            }
        }
        sessionTask.resume()
    }
    
}
