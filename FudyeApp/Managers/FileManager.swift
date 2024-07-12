//
//  FileManager.swift
//  FudyeApp
//
//  Created by Fatya on 30.05.24.
//

import Foundation

class FileManagerHelper {
    
    func getFilePath() -> URL {
           let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           let path = files[0].appendingPathComponent("users.json")
           print(path)
           return path
       }
       
       func saveUser(data: [RegisterModel]) {
           do {
               let encodedData = try JSONEncoder().encode(data)
               try encodedData.write(to: getFilePath())
           } catch {
               print("Failed to save user: \(error)")
           }
       }
       
       func getUser(complete: @escaping ([RegisterModel]) -> Void) {
           if let data = try? Data(contentsOf: getFilePath()) {
               do {
                   let users = try JSONDecoder().decode([RegisterModel].self, from: data)
                   complete(users)
               } catch {
                   print("Failed to decode user: \(error)")
                   complete([])
               }
           } else {
               print("No data found")
               complete([])
           }
       }
   }
