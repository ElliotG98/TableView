//
//  ViewController.swift
//  TableView
//
//  Created by Elliot Glaze on 16/09/2019.
//  Copyright © 2019 Elliot Glaze. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellId = "cellId"
    var names = [
        ExpandableNames(isExpanded: true, names: ["Adam", "Steve", "John", "Mary", "Spencer"]),
        ExpandableNames(isExpanded: true, names: ["Bob", "Greg", "Taylor"]),
        ExpandableNames(isExpanded: true, names: ["Fank", "Arthur", "Pip", "Marlo", "Nia"]),
        ExpandableNames(isExpanded: true, names: ["Basil"])
    ]
    var showIndexPaths = false
    
    @objc func handleShowIndexPath() {
        
        var indexPathsToReload = [IndexPath]()
        var isExpanded = false
        
        for section in names.indices {
            for row in names[section].names.indices {
                if names[section].isExpanded {
                    isExpanded = true
                }
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.left : .right
        if isExpanded{
            tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleOpenClose(button: UIButton) {
        var indexPaths = [IndexPath]()
        let section = button.tag
        
        for row in names[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = names[section].isExpanded
        names[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
           tableView.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[section].isExpanded ? names[section].names.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = names[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = name
        
        if showIndexPaths {
           cell.textLabel?.text = "\(name) Section: \(indexPath.section) Row: \(indexPath.row)"
        }
        
        return cell
    }


}

