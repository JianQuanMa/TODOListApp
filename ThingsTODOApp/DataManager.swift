//
//  DataManager.swift
//  ThingsTODOApp
//
//  Created by Jian Ma on 10/29/19.
//  Copyright © 2019 Jian Ma. All rights reserved.
//

import Foundation

public class DataManager{
    
    //access document directory
    static fileprivate func getDocumentDirectory() -> URL{
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            fatalError("unable to access document directory!")
        }
        return url
    }
    //save data
    static func save<T: Encodable>(_ object: T, with fileName: String){
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        do{
            let data = try JSONEncoder.init().encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
            }
        }catch{
            fatalError("unable to save file!")
            }
        
    }
    
}
