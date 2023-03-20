//
//  NoteModel.swift
//  todoApp
//
//  Created by Jeison Sierra on 19/03/23.
//

import Foundation

struct NoteModel: Codable {
    let id: String
    var isfavorite: Bool
    let description: String
    
    init(id: String = UUID().uuidString, isfavorite: Bool = false, description:String){
        self.id = id
        self.isfavorite = isfavorite
        self.description = description
    }
    
}
