//
//  NotesViewModel.swift
//  todoApp
//
//  Created by Jeison Sierra on 19/03/23.
//

import Foundation
import SwiftUI

final class NoteViewModel: ObservableObject{
    @Published var notes: [NoteModel] = []
    
    init() {
        self.notes = getAllNotes()
    }
    
    func saveNote(description: String){
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        EncodedAndSaveNotes()
    }
    
    private func EncodedAndSaveNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel]{
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data{
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        return []
    }
    
    func removeNote(withId id:String){
        notes.removeAll(where: {$0.id == id})
        EncodedAndSaveNotes()
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>){
        note.wrappedValue.isfavorite = !note.wrappedValue.isfavorite
        EncodedAndSaveNotes()
    }
    
    func getNumberOfNotes() -> String {
        "\(notes.count)"
    }
}
