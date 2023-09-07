//
//  PhotosViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit

class PhotosViewModel {
    var searchedText = ""
    
    
   
    var photo: [Photos] = [] {
        didSet {
            
            search(with: searchedText)
        }
    }
    var filteredPhotoArray: [Photos]? {
        didSet {
            bindingData(filteredPhotoArray,nil)
            
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var album: Album?
    var bindingData: (([Photos]?,Error?) -> Void) = {_,_ in }
    init(apiService: ApiService = NetworkManager(),album: Album?) {
        self.apiService = apiService
        self.album = album
    }
    
    func search(with: String) {
        searchedText = with
        if with.isEmpty {
            filteredPhotoArray = photo
            return
        }
       
        self.filteredPhotoArray = self.photo.filter { itemSearch in
            return itemSearch.title?.lowercased().contains(with.lowercased()) ?? false
        }
    }


        
    func getPhotosArray() {
        guard let albumId = album?.id else{return}
        apiService.getPhotos(albumId: albumId, endPoint: "photos") { photos, error in
            if let photos = photos {
                self.photo = photos
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
}

extension PhotosViewModel{

    func getPhotos() -> [Photos]?{
        return filteredPhotoArray
    }
    
    func getPhotos(indexPath: IndexPath) -> Photos?{
        return filteredPhotoArray?[indexPath.row]
    }
    
}
