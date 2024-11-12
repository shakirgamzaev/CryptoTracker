//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 11/11/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class CoinImageDownload {
    var image: UIImage?
    @ObservationIgnored
    private let coinModel: CoinModel
    var error: Error? = nil
    var isDownloading: Bool
    
    init(coinModel: CoinModel) {
        self.image = nil
        self.coinModel = coinModel
        self.isDownloading = true
        Task {
            await initialize()
        }
    }
    
    ///initializes a local file
    private func initialize() async {
        do {
            //TODO: if the image is not in the file system, download it, else simply retrieve it.
            let fileManager = LocalFileManager.shared
            let imageData = fileManager.getImage(imageName: coinModel.id, folderName: "CoinImages")
            // if we did not get the UiImage from a file, it means that we need make the network call to get the image data for a coin
            if imageData == nil {
                //print("DEBUG: get image from Network")
                let image = try await self.downloadCoinImage()
                await fileManager.saveImage(image: image, imageName: coinModel.id, folderName: "CoinImages")
                self.image = image
                self.isDownloading = false
            }
            else {
                //print("DEBUG: get image from file")
                self.image = imageData
                self.isDownloading = false
            }
        }
        catch let urlError as URLError {
            self.error = urlError
            self.isDownloading = false
        }
        catch let badDataError as DataError {
            self.error = badDataError
            self.isDownloading = false
        }
        catch {
            print("unknown error:" + error.localizedDescription)
            self.isDownloading = false
        }
    }
    
    
    private func downloadCoinImage() async throws -> UIImage {
        let data = try await NetworkManager.shared.getResource(from: URL(string: coinModel.image)!)
        let image = UIImage(data: data)
        if image == nil {
            throw DataError.badData
        }
        return image!
    }
}

extension CoinImageDownload {
    enum DataError: Error {
        case badData
    }
    
}
