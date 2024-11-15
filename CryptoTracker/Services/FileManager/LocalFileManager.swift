//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 11/11/24.
//

import Foundation
import SwiftUI

///a utility class that one can use to write png image Data to file and retrieve data from file.
@MainActor
class LocalFileManager {
    private let fileManager = FileManager.default
    static let shared = LocalFileManager()
    
     func saveImage(image: UIImage, imageName: String, folderName: String) async {
         createFolderIfNeeded(folderName: folderName)
         guard let imageData = image.pngData(),
         let imageURL = getImageURL(for: imageName, folderName: folderName) else {return}
         
         if !fileManager.fileExists(atPath: imageURL.path()) {
             fileManager.createFile(atPath: imageURL.path(), contents: nil)
         }
         await asyncSaveImageData(data: imageData, toFile: imageURL)
     }
    
     func getImage(imageName: String, folderName: String) async -> UIImage? {
        createFolderIfNeeded(folderName: folderName)
        guard let imageURL = getImageURL(for: imageName, folderName: folderName),
              fileManager.fileExists(atPath: imageURL.path()) else {return nil}
         let data = await asyncGetImageData(fromFile: imageURL)
         return UIImage(data: data)
    }
    
    nonisolated private func asyncGetImageData(fromFile url: URL) async -> Data {
        return try! Data(contentsOf: url)
    }
    
    //off load file saving to other thread
    nonisolated private func asyncSaveImageData(data: Data, toFile url: URL) async {
        do {
            try data.write(to: url)
        } catch  {
            print("error saving image data for image: \(url)")
        }
    }
    
    ///Returns the url to the folder that contains the files of PNG image data of all retrieved coins from CoinGecko
    private func getURLForFolder(folderName: String) -> URL? {
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            print("DEBUG: caches directory not found")
            return nil
        }
        let folderURL = cachesDirectory.appending(path: folderName)
        return folderURL
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let folderUrl = getURLForFolder(folderName: folderName) else {return}
        if !fileManager.fileExists(atPath: folderUrl.path()) {
            do {
                try fileManager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            } catch  {
                print("folder creation error: \(folderName). \(error.localizedDescription)")
            }
        }
    }
    
    private func getImageURL(for imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {return nil}
        let imageURL = folderURL.appending(path: imageName + ".png")
        return imageURL
    }
}
