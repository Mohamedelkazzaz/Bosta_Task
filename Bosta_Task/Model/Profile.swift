//
//  Profile.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation

struct Profile: Codable{
    
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
}

struct Address: Codable{
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

struct Geo: Codable{
    var lat, lng: String?
}

struct Company: Codable{
    var name, catchPhrase, bs: String?
}

