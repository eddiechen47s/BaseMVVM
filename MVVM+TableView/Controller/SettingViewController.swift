//
//  SettingViewController.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/5.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemFill
        tf.placeholder = "emailTextField"
        return tf
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemFill
        tf.placeholder = "addressTextField"
        return tf
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.alpha = 0.5
        return button
    }()
    
    private var viewModel = SettingViewModel()
    private let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupViewModel()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    deinit {
        print("SettingViewController deinit")
    }
    
    func setupViewModel() {
        viewModel.fetch {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.delegate = self
        bindViewModel()
    }
    
    func bindViewModel() {
        self.nameTextField.addTarget(self, action: #selector(self.bindTextField), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(self.bindTextField), for: .editingChanged)
        self.confirmButton.isEnabled = self.viewModel.isInActive
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.register(SettingViewCel.self, forCellReuseIdentifier: SettingViewCel.identifier)
    }
    
    func setupUI() {
        view.addsubviews(nameTextField,
                         emailTextField,
                         confirmButton,
                         tableView
        )
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc func tapButton() {
        // 預設
        self.viewModel.order.name = nameTextField.text ?? ""
        self.viewModel.order.email = emailTextField.text ?? ""
        self.viewModel.order.size = "large"
        self.viewModel.order.type = "latte"
        
        viewModel.load(vm: self.viewModel.order) {
            self.viewModel.fetch {
                print("\nPOST Success!!\n")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    @objc func bindTextField() {
        self.viewModel.email = self.nameTextField.text ?? ""
        self.viewModel.address = self.emailTextField.text ?? ""
        self.confirmButton.isEnabled = self.viewModel.isInActive
        self.confirmButton.alpha = self.viewModel.isInActive ? 1 : 0.5
    }
    
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingViewCel.identifier, for: indexPath) as! SettingViewCel
        cell.configure(vm: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SettingViewController: SignDelegate {
    func didIsSign(signed: Bool) {
        if signed {
            print("isSign")
        } else {
            print("failedSign")
        }
    }
    
    
    
    
}

