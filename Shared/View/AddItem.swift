//
//  AddItem.swift
//  Task_Watch WatchKit Extension
//
//  Created by Michele Manniello on 23/02/21.
//

import SwiftUI

struct AddItem: View {
    @State var memoText = ""
//    Getting context from enviroment
    @Environment(\.managedObjectContext) var contex
//    Presentation..
    @Environment(\.presentationMode) var presentation
//    Edit Options
    var memoItem : Memo?
    
    var body: some View {
        VStack(spacing:15) {
            TextField("Memories", text: $memoText)
            Button(action: {
                addmemo()
            }, label: {
                Text("Save")
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .background(Color.green)
                    .cornerRadius(15)
            })
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(memoText == "")
        }
        .navigationTitle("\(memoItem == nil ? "Add Memo": "Update")")
        .onAppear(perform: {
            if let memo = memoItem{
                memoText = memo.title ?? ""
            }
        })
    }
//    Addind memo
    func addmemo(){
        let memo = memoItem == nil ?  Memo(context: contex) : memoItem!
        memo.title = memoText
        memo.dateAdded = Date()
//        Salvataggio
        do{
            try contex.save()
//            if succes
//            closing view
            presentation.wrappedValue.dismiss()
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
