
//
//  DataTableViewController.swift
//  LWY
//
//  Created by ant on 2018/5/24.
//  Copyright © 2018年 com.cornerant. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController {
    
    var data = [DataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        loadData()
    }

    func configTableView() {
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
        tableView.separatorStyle = .none;
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never

        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
        tableView.contentInset.top = 64
        
    }
    
    func loadData() {
        MockAPIProvider.request(MockAPI.data) { [weak self] (result) in
            switch result {
            case let .success(response):
                self?.data = DataModel.loadDataModels(data: response.data)
                self?.tableView.reloadData()
            case .failure(_): break
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "data") as! DataTableViewCell
        let datamodel = data[indexPath.section]
        cell.comfigCell(with: datamodel)
        cell.delegate = self
        return cell
        
    }

}

extension DataTableViewController :DataTableViewCellDelegate{
    
    func typeButtonClick(cell: DataTableViewCell, button: UIButton) {
        switch button.tag {
        case 1: // a
            let vc = AViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 2: // b
            let vc = BViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            _ = ""
        }
    }
}
