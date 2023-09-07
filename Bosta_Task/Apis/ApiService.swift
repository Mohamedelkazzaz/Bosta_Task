//
//  ApiService.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit

protocol ApiService{
    func getUser(endPoint: String, completion: @escaping (([Profile]?, Error?) -> Void))
    func getAlbums(userId: Int, endPoint: String, completion: @escaping (([Album]?, Error?) -> Void))
    func getPhotos(albumId: Int,endPoint: String,completion: @escaping (([Photos]?, Error?) -> Void))

}
