//
//  UserViewModel.swift
//  MVVM+TableView
//
//  Created by ktrade on 2020/12/8.
//

import Foundation

class UserViewModel {
    
    var user = [User]()
    
    // 逃逸一個 closure
    func load(completion: @escaping () -> Void) {
        let apiUrl = URL(string: "https://api.androidhive.info/contacts/")!
        
        let resource = Resource<UserList>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let data):
                self?.user = data.contacts
                completion()
            case .failure(let err):
                print(err)
            }
        }
        
    }
    
}

