//
//  NetworkManager.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import Alamofire
import UIKit


class NetworkManager: ApiService{
    
    
    func getUser(endPoint: String, completion: @escaping ((Profile?, Error?) -> Void)) {
        guard let url = URL(string: Url(endPoint: endPoint).url) else {return}
        print(url)
      
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in

                switch res.result{
                case .failure(let error):
                    print("error")
                    completion(nil, error)
                case .success(_):

                    guard let data = res.data else { return }
                    
                    do{
                        let json = try JSONDecoder().decode(Profile.self, from: data)

                        completion(json, nil)
                        
                    }catch let error{
                        
                        print(error)
                        completion(nil, error)
                    }
                }
            }
    }
    
    func getAlbums(endPoint: String, completion: @escaping (([Album]?, Error?) -> Void)) {
        guard let url = URL(string: Url(endPoint: endPoint).url) else {return}
        print(url)
      
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in

                switch res.result{
                case .failure(let error):
                    print("error")
                    completion(nil, error)
                case .success(_):

                    guard let data = res.data else { return }
                    
                    do{
                        let json = try JSONDecoder().decode([Album].self, from: data)

                        completion(json, nil)
                        
                    }catch let error{
                        
                        print(error)
                        completion(nil, error)
                    }
                }
            }
    }
    
    func getPhotos(endPoint: String, completion: @escaping (([Photos]?, Error?) -> Void)) {
        guard let url = URL(string: Url(endPoint: endPoint).url) else {return}
        print(url)
      
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in

                switch res.result{
                case .failure(let error):
                    print("error")
                    completion(nil, error)
                case .success(_):

                    guard let data = res.data else { return }
                    
                    do{
                        let json = try JSONDecoder().decode([Photos].self, from: data)

                        completion(json, nil)
                        
                    }catch let error{
                        
                        print(error)
                        completion(nil, error)
                    }
                }
            }
    }
    
    
}
