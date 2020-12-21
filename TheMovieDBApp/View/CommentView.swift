//
//  CommentView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 21/12/20.
//

import SwiftUI

struct CommentView: View {
    
    let comment: Comment
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.systemBackground))
                .shadow(color: .primary, radius: 5)
            
            VStack (alignment: .leading) {
//                HStack {
                    Text(comment.author)
                        .font(.body)
                        .bold()
                        .foregroundColor(.primary)
//                        .padding(.bottom, 5)
                    
//                    Spacer()
                    
                    Text(toDate(date: comment.updated_at), style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 5)
//                }
//                .padding(.bottom, 5)
                
                if comment.author_details.rating != nil {
                    HStack {
                        ForEach(1...10, id: \.self) { count in
                            Image(systemName: "star.fill")
                                .foregroundColor(count <= comment.author_details.rating ?? 0 ? .yellow : .secondary)
                        }
                    }
                    .padding(.bottom, 10)
                }
               
                

                Text(comment.content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
        }
    }
    
    func toDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let result = dateFormatter.date(from: date) {
            print(result)
            return result
        } else {
            return Date()
        }
        
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment.init(id: "abcda", author: "DT", updated_at: "2017-02-13T22:23:01.268Z", author_details: CommentAuthor(name: "aaa", rating: 6), content: "HOHOHO"))
    }
}
