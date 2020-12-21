//
//  Extension+View.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 21/12/20.
//

import Foundation
import SwiftUI

extension View {
    
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor? = nil) -> some View {
        
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    
}
