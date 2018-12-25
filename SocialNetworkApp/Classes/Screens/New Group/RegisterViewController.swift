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
    
    private let models: [HeaderModel] = [.info, .sex, .birthday]
    private var registerModel = RegisterModel()
    private let datePickerView: UIDatePicker = { //скобки для инициализации переменной сразу
        let picker = UIDatePicker()
        picker.maximumDate = Date()
        return picker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Registration"
        
        Decorator.decorate(vc: self)
        registerCells()
        delegating()
        configureDatePickerView()
        addRigthBarButton()
    }
    
    private func addRigthBarButton() { // Правая кнопка нав бара
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rigthBarButtonClicked(sender:)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func rigthBarButtonClicked(sender: UIBarButtonItem) {
        guard registerModel.isFilled else {
            showAlert(with: "Error", and: "Fill in all fields")
            return
        }
    }
    
    private func configureDatePickerView () { // пикер вю
        datePickerView.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    @objc private func datePickerChanged(sender: UIDatePicker) {
        let date = sender.date
        print(date)
    }

    private func delegating() { // подпимали делегат и дата сорс
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)// приячим навигейшен бар
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func photoViewClicked() { // нажатие на фото
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
    }
    
    private func registerCells() { // зарегистрировали ячейки
        tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
        tableView.register(SegmentedTableViewCell.nib, forCellReuseIdentifier: SegmentedTableViewCell.name)
        tableView.register(TextFieldCellTableViewCell.nib, forCellReuseIdentifier: TextFieldCellTableViewCell.name)

    }
}
extension RegisterViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] else {
            return
        }
    }
}
extension RegisterViewController {
    fileprivate enum CellModel {
        case userInfo
        case sex
        case birthday
    }
    fileprivate enum HeaderModel: CellHeaderProtocol {
        typealias  CellType = CellModel
        case info
        case sex
        case birthday
        
        var cellModels: [RegisterViewController.CellModel] {
            switch self {
                case .info: return [.userInfo]
                case .sex: return [.sex]
                case .birthday: return[.birthday]
            }
        }
    }
}
extension RegisterViewController {
    private static let tableViewTopInsets: CGFloat = 16
    fileprivate class Decorator {
        static func decorate(vc: RegisterViewController) {
            vc.tableView.keyboardDismissMode = .onDrag //убрать клавиатуру при свайпе
            vc.tableView.separatorColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
            vc.tableView.backgroundColor = .clear
            vc.navigationController?.navigationBar.prefersLargeTitles = true
            vc.tableView.contentInset = UIEdgeInsets(top: tableViewTopInsets, left: 0, bottom: 0, right: 0) // отступ вверху таблицы
        }
    }
}
// высота ячейки
extension RegisterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .userInfo:
            return 100
        case .sex, .birthday:
            return 44
        }
    }
}

extension RegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerModel = models[section]
        switch headerModel {
        case .sex:
            let view = HeaderTitleView.loadFromNib()
            view.set(title: "Gender:")
            return view
        default: return nil
        }
    }
                       // высота отступа ячейки
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModel = models[section]
        switch headerModel {
        case .sex, .birthday:
            return 44
        default: return 0
        }
    }
    
    // вызываем зарегестрированию ячейку и нужными елементами класса
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .userInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.name, for: indexPath) as? InfoUserTableViewCell {
                cell.photoViewClicked = self.photoViewClicked
                return cell
            }
        case .sex:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedTableViewCell.name, for: indexPath) as? SegmentedTableViewCell {
                cell.indexChanged = {
                    index in
                    print(index)
                }
                return cell
            }
        case .birthday:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCellTableViewCell.name, for: indexPath) as? TextFieldCellTableViewCell {
                cell.textField.inputView = datePickerView
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].cellModels.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
}
