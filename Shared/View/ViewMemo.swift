//
//  ViewMemo.swift
//  Task_Watch WatchKit Extension
//
//  Created by Michele Manniello on 24/02/21.
//

import SwiftUI
import CoreData

struct ViewMemo: View {
//    core data fetch request
//    Were getting memos At descending order by using added or modified date...
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results : FetchedResults<Memo>
//    context ..
    @Environment(\.managedObjectContext) var context
    @State var confermaRating : Bool = false
    @State var statorating : Bool = false
    var body: some View {
        List(results){ item in
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
                Spacer(minLength : 4)
//                Edit Button
                NavigationLink(
                    destination: AddItem(memoItem:item),
                        label:{
                    Image(systemName: "square.and.pencil")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .cornerRadius(8)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .onLongPressGesture {
//               settare il rating dell item
                Rating(memo: item)
            }
        }
        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No Memo's found": "")
        )
        .navigationTitle("Memo's")
        .alert(isPresented: $confermaRating, content: {
            Alert(title: Text("Rating"), message: Text("\(statorating ? "Rating is delete" : "Rating is added" )"), dismissButton: .default(Text("Ok")))
        })
    }
    func Rating( memo : Memo){
         memo.rating.toggle()
        print("memo rating \(memo.rating)")
        statorating = memo.rating
        do{
           try  context.save()
            confermaRating.toggle()
        }catch{
            print(error.localizedDescription)
        }
        
    }
}

struct ViewMemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewMemo()
    }
}
