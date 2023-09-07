//
//  ProfileViewModel.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import Foundation
import UIKit


class ProfileViewModel {
    var profile: Profile? {
        didSet {
            bindingData(profile,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: ((Profile?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func getUsers(endPoint: String) {
        apiService.getUser(endPoint: endPoint) { profile, error in
            if let profile = profile {
                self.profile = profile
            }
            if let error = error {
                self.error = error
            }
        }
    }
}


