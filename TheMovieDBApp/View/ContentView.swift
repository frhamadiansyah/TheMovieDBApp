//
//  ContentView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var homeVM = HomeViewModel.shared
    
    @Environment(\.managedObjectContext) var context
    
    @State var isShow: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {

                VStack(spacing: 0) {
                    MovieListView()
                        .disabled(isShow ? true : false)
                        .opacity(isShow ? 0.3 : 1)
                    CategoryButton(isShow: $isShow)

                }
                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    self.isShow = false
                }
                .navigationTitle(homeVM.dbCategory.rawValue)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(backgroundColor: UIColor(named: "Primary")?.withAlphaComponent(isShow ? 0.3 : 1))
                .navigationBarItems(
                    trailing:
                        NavigationLink(
                            destination: LovedMoviesView( favoriteVM: FavoriteViewModel(managedObjectContext: context)),
                            label: {
                                Image(systemName: "heart.fill")
                                
                            }
                        )
                )
            }
            
        }
        
        
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
