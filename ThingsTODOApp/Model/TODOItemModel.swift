//
//  TODOItemModel.swift
//  ThingsTODOApp
//
//  Created by Jian Ma on 10/29/19.
//  Copyright © 2019 Jian Ma. All rights reserved.
//

import Foundation

struct TODOItem: Codable{
    var  title: String
    var completed: Bool
    var createdAt: Date
    var itemIdentifier: UUID
    
    func saveItem(){
        
    }
    func deleteItem(){
        
    }
    func markAsCompleted(){
        
    }
}
