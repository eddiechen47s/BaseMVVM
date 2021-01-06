//
//  SettingViewModel.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/5.
//

import UIKit

protocol SignDelegate: AnyObject {
    func didIsSign(signed: Bool)
}

class SettingViewModel: APIClient {
    var order = AddCoffeeOrder()
    var data = [AddCoffeeOrder]()
    weak var delegate: SignDelegate?
    var email = ""
    var address = ""
    var isInActive: Bool {
        return email != "" && address != ""
    }
    
    func load(vm: AddCoffeeOrder ,completion: @escaping () -> Void) {
        APIClient.shared.load(resource: create(url: APIParam.coffee.url, vm: vm)){ [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.didIsSign(signed: true)
                completion()
            case .failure(let err):
                self?.delegate?.didIsSign(signed: false)
                print(err)
            }
        }
        
    }
    
    func fetch(completion: @escaping () -> Void) {
        let apiUrl = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders")!

        let resource = Resource<[AddCoffeeOrder]>(url: apiUrl)
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let json):
                self?.data = json
                completion()
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
