//
//  ListController.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/28/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import UIKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvPerson: UITableView!
    
    let cellID = "cell"
    var items: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvPerson.dataSource = self
        tvPerson.delegate = self
        
        ApiServiceV2.sharedInstance.listPerson() { data, response, error in
            self.items = try! JSONDecoder().decode([Person].self, from: data!)
            self.tvPerson.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tvPerson.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = items[indexPath.row].name!
        cell?.detailTextLabel?.text = "\(items[indexPath.row].title!). Salario: S/ \(items[indexPath.row].salary!)"
        return cell!
    }
}
