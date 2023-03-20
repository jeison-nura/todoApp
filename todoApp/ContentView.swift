//
//  ContentView.swift
//  todoApp
//
//  Created by Jeison Sierra on 19/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var descriptionNote: String = ""
    @StateObject var noteViewModel = NoteViewModel()
    var body: some View {
        NavigationView{
            VStack{
                Text("agrega una tarea")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.gray)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(.blue, lineWidth: 2).tint(.white))
                    .padding(.horizontal, 12).cornerRadius(6.0)
                Button("crear"){
                    noteViewModel.saveNote(description: descriptionNote)
                    descriptionNote=""
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                Spacer()
                List{
                    ForEach($noteViewModel.notes, id: \.id){
                        $note in HStack {
                            if note.isfavorite {
                                Text("✨")
                            }
                            Text(note.description).swipeActions(edge: .trailing){
                                Button {
                                    noteViewModel.updateFavoriteNote(note: $note)
                                } label: {
                                    Label("Favorite", systemImage: "star.fill")
                                }.tint(.yellow)
                            }.swipeActions(edge: .leading){
                                Button {
                                    noteViewModel.removeNote(withId: note.id)
                                } label: {
                                    Label("delete", systemImage: "trash.fill")
                                }.tint(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{Text(noteViewModel.getNumberOfNotes())}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
