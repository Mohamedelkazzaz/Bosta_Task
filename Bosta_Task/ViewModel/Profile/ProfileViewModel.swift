//
//  ProfileViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit
import RxSwift


class ProfileViewModel {
    private let disposeBag = DisposeBag()
    
     let profilesSubject = PublishSubject<[Profile]>()
     let profileSubject = PublishSubject<Profile?>()
    private let errorSubject = PublishSubject<Error>()
     var albumsSubject = PublishSubject<[Album]>()
    private var profileId = 0
    
    var profilesObservable: Observable<[Profile]> {
        return profilesSubject.asObservable()
    }
    
    var profileObservable: Observable<Profile?> {
        return profileSubject.asObservable()
        
    }
    
    var errorObservable: Observable<Error> {
        return errorSubject.asObservable()
    }
    
    var albumsObservable: Observable<[Album]> {
        return albumsSubject.asObservable()
    }
        var profile: Profile? {
            didSet {

                profileSubject.onNext(profile)
                
            }
        }
    
    var albumArray: [Album]? {
        didSet {
            albumsSubject.onNext(albumArray ?? [])
            getAlbumsArray()
        }
    }
    
    let apiService: ApiService
    
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func getUsers() {
         apiService
             .getUser(endPoint: "users")
             .subscribe(onNext: { [weak self] profiles in
                 let array = profiles.0?.shuffled() ?? []
                 self?.profilesSubject.onNext(array)
                 
                 self?.profileSubject.onNext(array.first)
                 self?.profileId = profiles.0?.first?.id ?? 0
                 self?.getAlbumsArray()
                 self?.albumsSubject.onNext(self?.albumArray ?? [])
                 
             }, onError: { [weak self] error in
                 self?.errorSubject.onNext(error)
             })
             .disposed(by: disposeBag)
     }
    
    func getAlbumsArray() {

        apiService
            .getAlbums(userId: profileId, endPoint: "albums")
            .subscribe(onNext: { [weak self] albums in
                self?.albumsSubject.onNext(albums.0 ?? [])
                self?.albumArray = albums.0
            }, onError: { [weak self] error in
                self?.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
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
