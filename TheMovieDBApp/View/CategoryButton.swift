//
//  CategoryButton.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import SwiftUI

struct CategoryButton: View {
    
    @ObservedObject var homeVM = HomeViewModel.shared
    let safeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom
    
    @Binding var isShow: Bool
    
    var body: some View {
        //        GeometryReader{ geometry in
        //            VStack(spacing: 0) {
        
        Button(action: {
            self.isShow.toggle()
        }, label: {
            HStack {
                Spacer()
                Text("Categories")
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .padding(.bottom, safeArea)
            .background(Color("Primary"))

            
            
        })
        .overlay(
            VStack {
                if isShow {
                    HStack {
                        Spacer()
                        VStack{
                            ForEach(DBCategory.allCases, id: \.self) { category in
                                Button(action: {
                                    homeVM.dbCategory = category
                                    self.isShow.toggle()
                                }, label: {
                                    Text(category.rawValue)
                                        .padding(.vertical, 10)
                                })
                                
                            }
                        }
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, safeArea)
            , alignment: .bottom)
        
        
        //            }
        //        }
        
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(isShow: .constant(false))
    }
}
