//
//  RegisterViewController.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var cellModels: [CellModel] = [.userInfo]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Registration"
        Decorator.decorate(vc: self)
        registerCells()
        delegating()
    }

    private func delegating() { // подпимали делегат и дата сорс
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)// приячим навигейшен бар
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func registerCells() { // зарегистрировали ячейку
        tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
    }
}

extension RegisterViewController {
    fileprivate enum CellModel {
        case userInfo
        case sex
        case birthday
    }
}
extension RegisterViewController {
    private static let tableViewTopInsets: CGFloat = 16
    fileprivate class Decorator {
        static func decorate(vc: RegisterViewController) {
            vc.tableView.separatorColor = .clear
            vc.tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
            vc.navigationController?.navigationBar.prefersLargeTitles = true
            vc.tableView.contentInset = UIEdgeInsets(top: tableViewTopInsets, left: 0, bottom: 0, right: 0) // отступ вверху таблицы
        }
    }
}

extension RegisterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = cellModels[indexPath.row]
        switch model {
        case .userInfo:
            return 100
        default:
            return 0
        }
    }
}

extension RegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = HeaderTitleView.loadFromNib()
        view.set(title: "Gender:")
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        switch model {
        case .userInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.name, for: indexPath) as? InfoUserTableViewCell {
                return cell
            }
        default: break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
