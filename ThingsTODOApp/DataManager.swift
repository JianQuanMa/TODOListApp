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
            let data = try JSONEncoder().encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch{
            fatalError("unable to save file!")
        }
    }
    //load data with a format
    static func load<T: Decodable>(with fileName: String, as fileType: T) -> T{
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        guard !FileManager.default.fileExists(atPath: url.path) else{fatalError("File not exist!ed at \(url.path)")}
        if let data = FileManager.default.contents(atPath: url.path){
            do{
                let model = try JSONDecoder().decode(T.self, from: data)
                return model
            }catch{
                fatalError("could not load data")
            }
            
        }else{
            fatalError("data unavailable!")
        }
    }
    //load data as it is
    static func load(with fileName: String) -> Data?{
           let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
           guard !FileManager.default.fileExists(atPath: url.path) else{fatalError("File not exist!ed at \(url.path)")}
           if let data = FileManager.default.contents(atPath: url.path){
              return data
           }else{
               fatalError("data unavailable!")
           }
       }
    
    //load all files
    static func loaddAll<T: Decodable>(_ type: T) -> [T]{
        do{
            let url = getDocumentDirectory().path
            let allFiles = try FileManager.default.contentsOfDirectory(atPath: url)
            var modelObjects = [T]()
            allFiles.forEach{ file in
                modelObjects.append(load(with: file, as: type))
            }
            return modelObjects
        }catch{
            fatalError("could not load files")
                }
    }
    
}
