//
//  ProfileViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit


class ProfileViewModel {
    var profilesArray: [Profile]?{
        didSet {
            profile = profilesArray?.first
        }
    }
    var profile: Profile? {
        didSet {
            onProfileRecived?(profile)
            getAlbumsArray()
        }
    }
    var error: Error? {
        didSet {
            onErrorRecived?(error)
        }
    }
    var albumArray: [Album]? {
        didSet {
            onAlbumRecived?(albumArray)
        }
    }
    let apiService: ApiService
    var onProfileRecived: ((Profile?) -> Void)?
    var onAlbumRecived: (([Album]?) -> Void)?
    var onErrorRecived: ((Error?) -> Void)?
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func getUsers() {
        apiService.getUser(endPoint: "users") { profile, error in
            if let profile = profile {
                self.profilesArray = profile.shuffled()
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func getAlbumsArray() {
        guard let profileId = profile?.id else{return}
        apiService.getAlbums(userId: profileId,endPoint: "albums") { albums, error in
            if let albums = albums {
                self.albumArray = albums
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
}

extension ProfileViewModel{

    func getAlbums() -> [Album]?{
        return albumArray
    }
    
    func getAlbums(indexPath: IndexPath) -> Album?{
        return albumArray?[indexPath.row]
    }
    
}

