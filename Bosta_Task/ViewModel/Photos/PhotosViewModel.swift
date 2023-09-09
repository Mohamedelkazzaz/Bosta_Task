//
//  PhotosViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit
import RxSwift


class PhotosViewModel {
    var searchedText = ""
    
    var photo: [Photos] = [] {
        didSet {
            search(with: searchedText)
        }
    }
    
    var filteredPhotoArray: Observable<[Photos]?> {
        return filteredPhotoArraySubject.asObservable()
    }
    
    var error: Observable<Error?> {
        return errorSubject.asObservable()
    }
    var photosArray: [Photos]? {
        didSet {
            photoSubject.onNext(photosArray ?? [])
        }
    }
    
    private let apiService: ApiService
     var album: Album?
    private let disposeBag = DisposeBag()
    private let filteredPhotoArraySubject = PublishSubject<[Photos]?>()
    private let errorSubject = BehaviorSubject<Error?>(value: nil)
     let photoSubject = PublishSubject<[Photos]>()

    
    init(apiService: ApiService = NetworkManager(), album: Album?) {
        self.apiService = apiService
        self.album = album
    }
    
    func search(with searchText: String) {
        searchedText = searchText
        if searchText.isEmpty {
            filteredPhotoArraySubject.onNext(photo)
            return
        }
        
        let filteredPhotos = photo.filter { itemSearch in
            return itemSearch.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        
        filteredPhotoArraySubject.onNext(filteredPhotos)
    }
    
    func getPhotosArray() {
        guard let albumId = album?.id else { return }
        apiService.getPhotos(albumId: albumId, endPoint: "photos")
            .subscribe(onNext: { [weak self] photos in
                print(photos)
                self?.photoSubject.onNext(photos.0 ?? [])
                
                self?.photosArray = photos.0
            }, onError: { [weak self] error in
                self?.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    

    
}

extension PhotosViewModel{

    func getPhotos() -> [Photos]?{
        return photosArray
    }
    
    func getPhotos(indexPath: IndexPath) -> Photos?{
        return photosArray?[indexPath.row]
        }
    

    
}
