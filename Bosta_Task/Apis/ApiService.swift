//
//  ApiService.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit

protocol ApiService{
    func getUser(endPoint: String, completion: @escaping ((Profile?, Error?) -> Void))
    func getAlbums(endPoint: String, completion: @escaping (([Album]?, Error?) -> Void))
    func getPhotos(endPoint: String,completion: @escaping (([Photos]?, Error?) -> Void))
//    func animalDetails(endPoint: String,completion: @escaping ((Animal?, Error?) -> Void))
}
