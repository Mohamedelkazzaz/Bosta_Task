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
            getAlbums(endPoint: "albums")
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
    
    func getUsers(endPoint: String) {
        apiService.getUser(endPoint: endPoint) { profile, error in
            if let profile = profile {
                self.profilesArray = profile.shuffled()
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func getAlbums(endPoint: String) {
        guard let profileId = profile?.id else{return}
        apiService.getAlbums(userId: profileId,endPoint: endPoint) { albums, error in
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

