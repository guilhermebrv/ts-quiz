//
//  ChooseEraVCViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

class ChooseEraModalVC: UIViewController {
    
    let data = TaylorEras(era1column: ["taylor-swift", "speak-now", "1989", "lover", "evermore"],
                          era2column: ["fearless", "red", "reputation", "folklore", "midnights"])
    
    var chooseEraView: ChooseEraModalView?
        
    override func loadView() {
        chooseEraView = ChooseEraModalView()
        view = chooseEraView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseEraView?.erasTableView.delegate = self
        chooseEraView?.erasTableView.dataSource = self
        chooseEraView?.erasTableView.register(ErasTableViewCell.self, forCellReuseIdentifier: ErasTableViewCell.identifier)
    }
}

extension ChooseEraModalVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.era1column.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ErasTableViewCell.identifier, for: indexPath) as? ErasTableViewCell
                
        let firstPicture = data.era1column[indexPath.row]
        let secondPicture = data.era2column[indexPath.row]
                
        cell?.chooseEraButton1.setBackgroundImage(UIImage(named: firstPicture), for: .normal)
        cell?.chooseEraButton2.setBackgroundImage(UIImage(named: secondPicture), for: .normal)
        
        cell?.tappedChooseEraButton1()
        
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
