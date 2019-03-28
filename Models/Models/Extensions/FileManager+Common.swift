//
//  FileManager+Common.swift
//  Models
//
//  Created by Xinghou Liu on 28/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

//extension FileManager {
//    
//    //MARK: - Private
//    public func hasCache(for fileName: PersistentFiles) -> Bool {
//        var isExist = false
//        if let filePath = fileUrl(with: fileName)?.path {
//            isExist = FileManager.default.fileExists(atPath: filePath)
//        }
//        return isExist
//    }
//    
//    public func save<DataType: Encodable>(from objects: [DataType], to fileName: PersistentFiles) throws {
//        if let url = fileUrl(with: fileName) {
//            let data = try JSONEncoder().encode(objects)
//            try data.write(to: url, options: .atomic)
//        }
//    }
//    
//    public func delete(fileName: PersistentFiles) throws {
//        if let url = fileUrl(with: fileName) {
//            try self.removeItem(at: url)
//        }
//    }
//    
//    public func get<DataType: Decodable>(from fileName: PersistentFiles) throws -> [DataType] {
//        var objects: [DataType] = []
//        
//        if let url = fileUrl(with: fileName) {
//            let data = try Data(contentsOf: url)
//            let objectArray = try JSONDecoder().decode([DataType].self, from: data)
//            objects = objectArray
//        }
//        return objects
//    }
//    
//    public func fileUrl(with name: PersistentFiles) -> URL? {
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        return dir?.appendingPathComponent(name.rawValue)
//    }
//}
