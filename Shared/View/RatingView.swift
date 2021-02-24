//
//  RatingView.swift
//  Task_Watch WatchKit Extension
//
//  Created by Michele Manniello on 24/02/21.
//

import SwiftUI
import CoreData

struct RatingView: View {
    
    @FetchRequest(entity: Memo.entity(),
                  sortDescriptors: [
                        NSSortDescriptor(keyPath: \Memo.rating, ascending: false)],
                  predicate: NSPredicate(format: "rating == %@","true") // quary sul valore
                  ,animation: .easeIn) var results : FetchedResults<Memo>
    
    var body: some View {
        List (results){ item in
            HStack(spacing:10) {
            VStack(alignment: .leading, spacing: 3, content: {
                Text(item.title ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                Text("Last Modifier")
                    .font(.system(size: 8))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.top,4)
                Text(item.dateAdded ?? Date(),style: .date)
                    .font(.system(size: 8))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            })
        }
        }
        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No Rating": "")
        )
        .navigationTitle("Rating")
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
