//
//  ViewController.swift
//  MVVM+TableView
//
//  Created by ktrade on 2020/12/8.
//
//  API: https://api.androidhive.info/contacts/

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let tableView = UITableView()
    private var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupViewModel()
        
        setupNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    deinit {
        print("ViewController deinit")
    }
    
    private func setupViewModel() {
        
        viewModel.load {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupNav() {
        
        let addBarButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(tapAdd))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.register(UserViewCell.self, forCellReuseIdentifier: UserViewCell.identifier)
    }
    
    
    @objc func tapAdd() {
        let controller = SettingViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.user[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserViewCell.identifier, for: indexPath) as! UserViewCell
        cell.configure(vm: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
