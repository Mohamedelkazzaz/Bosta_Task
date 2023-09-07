//
//  PhotosViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit

class PhotosViewModel {
   
    var photoArray: [Photos]? {
        didSet {
            bindingData(photoArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: (([Photos]?,Error?) -> Void) = {_,_ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }

        
    func getPhotos(endPoint: String) {
        apiService.getPhotos(endPoint: endPoint) { photos, error in
            if let photos = photos {
                self.photoArray = photos
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
}

extension PhotosViewModel{

    func getPhotos() -> [Photos]?{
        return photoArray
    }
    
    func getPhotos(indexPath: IndexPath) -> Photos?{
        return photoArray?[indexPath.row]
    }
    
}
