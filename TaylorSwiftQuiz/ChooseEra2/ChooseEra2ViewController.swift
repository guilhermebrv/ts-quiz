//
//  ChooseEra2ViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

class ChooseEra2ViewController: UIViewController {
    
    let eras: [String] = ["taylor-swift", "fearless", "speak-now", "red", "1989", "reputation", "lover", "folklore", "evermore", "midnights"]

    var chooseEra: ChooseEra2View?
    
    override func loadView() {
        chooseEra = ChooseEra2View()
        view = chooseEra
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseEra?.delegate(delegate: self)
        chooseEra?.erasTableView.delegate = self
        chooseEra?.erasTableView.dataSource = self
        chooseEra?.erasTableView.register(ChooseEra2TableViewCell.self, forCellReuseIdentifier: ChooseEra2TableViewCell.identifier)
        navigationController?.navigationBar.isHidden = true
    }
}

extension ChooseEra2ViewController: ChooseEra2ViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eras.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseEra2TableViewCell.identifier, for: indexPath) as? ChooseEra2TableViewCell
        
        let era = eras[indexPath.row]
        
        if era == TemporaryDataStorage.shared.eraOption {
            cell?.chooseEraButton.alpha = 1.0
        } else {
            cell?.chooseEraButton.alpha = 0.5
        }
        
        cell?.chooseEraButton.setBackgroundImage(UIImage(named: eras[indexPath.row]), for: .normal)

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TemporaryDataStorage.shared.eraOption = eras[indexPath.row]
        chooseEra?.nextButton.isEnabled = true
        if let cell = tableView.cellForRow(at: indexPath) as? ChooseEra2TableViewCell {
            cell.chooseEraButton.alpha = 1.0
        }
        tableView.reloadData()
    }
    
    func tappedStartGameButton() {
        chooseEra?.nextButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.chooseEra?.nextButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        let startgame = QuestionsVC()
        self.navigationController?.pushViewController(startgame, animated: true)
    }
    
    
    func tappedBackButton() {
        chooseEra?.backButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.chooseEra?.backButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
