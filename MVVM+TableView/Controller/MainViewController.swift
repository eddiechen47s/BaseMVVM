//
//  MainViewController.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/4.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        setupNav()
    }
    
    func setupNav() {
        
        let addBarButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(tapAdd))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    
    @objc func tapAdd() {
        let controller = ViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }


}
