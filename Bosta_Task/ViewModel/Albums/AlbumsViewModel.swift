//
//  AlbumsViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit

class AlbumsViewModel {
   
    var albumArray: [Album]? {
        didSet {
            bindingData(albumArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: (([Album]?,Error?) -> Void) = {_,_ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }

//    func didSelect(type: String){
//        self.selectedType = type
//
//    }
    

    
    func getAlbums(endPoint: String) {
        apiService.getAlbums(endPoint: endPoint) { albums, error in
            if let albums = albums {
                self.albumArray = albums
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
}

extension AlbumsViewModel{

    func getAlbums() -> [Album]?{
        return albumArray
    }
    
    func getAlbums(indexPath: IndexPath) -> Album?{
        return albumArray?[indexPath.row]
    }
    
}


