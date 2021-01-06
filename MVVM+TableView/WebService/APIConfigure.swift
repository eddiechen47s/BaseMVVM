//
//  APIConfigure.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/5.
//

import Foundation

enum APIParam: String, CaseIterable {
    case coffee
    
    var url: String {
        switch self {
        case .coffee:
            return "https://guarded-retreat-82533.herokuapp.com/orders"
        }
    }
}
