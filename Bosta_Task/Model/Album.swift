//
//  Album.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation

struct Albums: Codable{
    var album: [Album]?
}

struct Album: Codable{
    var userId: Int?
    var id: Int?
    var title: String?
}
