//
//  LocalFileManager.swift
//  Cryptara
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation
import SwiftUI
import Combine

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private var cancellables = Set<AnyCancellable>()
    
    private init() { }
    
    private func getUrlForImage(imageName: String,folderName: String) -> URL? {
        guard let folderUrl = getURlForFolder(folderName: folderName) else { return  nil}
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
    func saveImage(image:UIImage, imageName: String, folderName: String) {
        
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard   let data = image.pngData(),
                let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving Image. ImageName: \(imageName) \(error)")
        }
    }
    
    private func createFolderIfNeeded(folderName:String) {
        guard let url = getURlForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true,attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName:\(folderName) \(error)")
            }
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    
    
    private func getURlForFolder(folderName:String) -> URL? {
        guard   let url  = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil  }
        
        return url.appendingPathComponent(folderName)
    }
    
    func saveImageFromURL(imageUrl: String, imageName: String, folderName: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading image: \(error)")
                }
            } receiveValue: { [weak self] data in
                guard let image = UIImage(data: data) else {
                    print("Invalid image data for url: \(imageUrl)")
                    return
                }
                self?.saveImage(image: image, imageName: imageName, folderName: folderName)
            }
            .store(in: &cancellables)
    }
}
