//
//  ChooseEraViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

class ChooseEraViewController: UIViewController {
    private var screen: ChooseEraView?
    private let viewModel: ChooseEraViewModel = ChooseEraViewModel()
    override func loadView() {
        screen = ChooseEraView()
        view = screen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
    }
}

extension ChooseEraViewController {
    private func signProtocols() {
        screen?.delegate(delegate: self)
        screen?.erasTableView.delegate = self
        screen?.erasTableView.dataSource = self
    }
}

extension ChooseEraViewController: ChooseEraViewProtocol {
    func tappedStartGameButton() {
        if let button = screen?.nextButton {
            tappedButtonEffect(button: button)
        }
        let startgame = QuestionsViewController()
        self.navigationController?.pushViewController(startgame, animated: true)
    }
    func tappedBackButton() {
        if let button = screen?.backButton {
            tappedButtonEffect(button: button)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension ChooseEraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseEraTableViewCell.identifier, for: indexPath) as? ChooseEraTableViewCell
        let era = viewModel.eras[indexPath.row]
        if era == TemporaryDataStorage.shared.eraOption {
            cell?.selectEraEffect()
        } else {
            cell?.deselectEraEffect()
        }
        cell?.setupCell(era: viewModel.eras[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TemporaryDataStorage.shared.eraOption = viewModel.eras[indexPath.row]
        screen?.nextButton.isEnabled = true
        if let cell = tableView.cellForRow(at: indexPath) as? ChooseEraTableViewCell {
            cell.selectEraEffect()
        }
        tableView.reloadData()
    }
}
