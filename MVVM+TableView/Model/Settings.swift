//
//  Settings.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/5.
//

import Foundation

struct SettingsList: Codable {
    let contacts: [Settings]
}

struct Settings: Codable {
    let id: String
    let email: String
    let address: String
}



