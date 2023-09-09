//
//  NetworkManager.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import Alamofire
import UIKit
import RxSwift

class NetworkManager: ApiService{

    
    func getUser(endPoint: String) -> RxSwift.Observable<([Profile]?, Error?)> {
        return Observable.create { observer -> Disposable in
            guard let url = URL(string: Url(endPoint: "users").url) else {
                observer.onError(NSError(domain: "InvalidURL", code: 0, userInfo: nil))
                return Disposables.create()
            }
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .response { response in
                    switch response.result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let data):
                        do {
                            let profiles = try JSONDecoder().decode([Profile].self, from: data ?? Data())
                            observer.onNext((profiles,nil))
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    }
                }
            
            return Disposables.create()
        }
    }
    

    func getAlbums(userId: Int, endPoint: String) -> Observable<([Album]?, Error?)> {
        return Observable.create { observer -> Disposable in
            guard let url = URL(string: Url(endPoint: "albums").url) else {
                observer.onError(NSError(domain: "InvalidURL", code: 0, userInfo: nil))
                return Disposables.create()
            }
            let par = [ "userId": userId]
            AF.request(url, method: .get, parameters: par, encoding: URLEncoding.default, headers: nil)
                .response { response in
                    switch response.result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let data):
                        do {
                            let albums = try JSONDecoder().decode([Album].self, from: data ?? Data())
                            observer.onNext((albums,nil))
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    }
                }
            
            return Disposables.create()
        }
    }

    
    func getPhotos(albumId: Int, endPoint: String) -> Observable<([Photos]?, Error?)> {
        return Observable.create { observer -> Disposable in
            guard let url = URL(string: Url(endPoint: "photos").url) else {
                observer.onError(NSError(domain: "InvalidURL", code: 0, userInfo: nil))
                return Disposables.create()
            }
            let par = [ "albumId": albumId]
            AF.request(url, method: .get, parameters: par, encoding: URLEncoding.default, headers: nil)
                .response { response in
                    switch response.result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let data):
                        do {
                            let photos = try JSONDecoder().decode([Photos].self, from: data ?? Data())
                            observer.onNext((photos,nil))
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    }
                }
            
            return Disposables.create()
        }
        }
    }
    
    

