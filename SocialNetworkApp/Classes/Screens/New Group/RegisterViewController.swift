//
//  RegisterViewController.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit
import ARSLineProgress

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let models: [HeaderModel] = [.info, .sex, .birthday]
    private let sexModels: [Sex] = [.male, .female] 
    private var registerModel = RegisterModel() // переменная для обращения к модели
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
        updateDoneButtonStatus()
    }
    
    private func addRigthBarButton() { // Правая кнопка нав бара
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rigthBarButtonClicked(sender:)))
        navigationItem.rightBarButtonItem = barButton
    }
    private func updateDoneButtonStatus() { // кнопка не работате когда поля не заполнены
        navigationItem.rightBarButtonItem?.isEnabled = registerModel.isFilled
    }
    
    @objc func rigthBarButtonClicked(sender: UIBarButtonItem) {
        AuthManeger.shared.register(with: registerModel) { result in
            switch result {
            case .success(_):
                self.showAlert(with: "Ready", and: "You are registered")
            case .failure(let _):
                self.showAlert(with: "Error", and: "Fill in all fields")
            }
        }
    }
    
    private func configureDatePickerView () { // пикер вю, выбор даты
        datePickerView.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    @objc private func datePickerChanged(sender: UIDatePicker) {
        let date = sender.date
        print(date)
        registerModel.birthday = date // записали дату
        updateDoneButtonStatus()
    }

    private func delegating() { // подпиcали делегат и дата сорс
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
        imagePickerController.sourceType = .photoLibrary // выбрать из раздела
        present(imagePickerController, animated: true, completion: nil) // показать
        
    }
    
    private func registerCells() { // зарегистрировали ячейки
        tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
        tableView.register(SegmentedTableViewCell.nib, forCellReuseIdentifier: SegmentedTableViewCell.name)
        tableView.register(TextFieldCellTableViewCell.nib, forCellReuseIdentifier: TextFieldCellTableViewCell.name)

    }
}
extension RegisterViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // был сделан выбор фото
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.registerModel.photo = image // выбор картинки
        updateDoneButtonStatus() // статус кнопки продолжить
        tableView.reloadData() // обновить таблицу
        ARSLineProgress.show() //показать загрузку
        StorageManager.shared.upload(photo: image, by: registerModel){ // загрузка картинки
            ARSLineProgress.hide() // выключить загрузку
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
                cell.topTextChanged = { //при изменениях текста меняеться данные модели
                    text in
                    self.registerModel.email = text
                    self.updateDoneButtonStatus()
                }
                cell.bottomTextChanged = {
                    text in
                    self.registerModel.password = text
                    self.updateDoneButtonStatus()
                }
                cell.photoViewClicked = self.photoViewClicked
                cell.set(image: registerModel.photo)
                return cell
            }
        case .sex:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedTableViewCell.name, for: indexPath) as? SegmentedTableViewCell {
                // поставили название сагментам
                cell.set(titels: sexModels.map{$0.rawValue.capitalized})
                cell.indexChanged = {
                    index in
                    let sex  = self.sexModels[index]
                    self.registerModel.sex = sex
                    self.updateDoneButtonStatus()
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
