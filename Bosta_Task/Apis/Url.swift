//
//  Url.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation

struct Url {
    var endPoint: String = ""
    var url: String {
        return "https://jsonplaceholder.typicode.com/\(endPoint)"
    }
}
