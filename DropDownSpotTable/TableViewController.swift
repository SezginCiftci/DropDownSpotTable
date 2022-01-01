//
//  TableViewController.swift
//  DropDownSpotTable
//
//  Created by Sezgin Çiftci on 27.12.2021.
//

import UIKit

class TableViewController: UITableViewController {

    fileprivate let CELL_ID = "CELL_ID"
    fileprivate var sections: [SectionData] = [
        SectionData(
            open: true,
            data: [
                CellData(title: "Twitter", featureImage: UIImage(named: "1")!),
                CellData(title: "Facebook", featureImage: UIImage(named: "2")!)
            ]),
        SectionData(
            open: true,
            data: [
                CellData(title: "Twitter", featureImage: UIImage(named: "2")!),
                CellData(title: "Instagram", featureImage: UIImage(named: "0")!)
            ]),
        SectionData(
            open: true,
            data: [
                CellData(title: "Youtube", featureImage: UIImage(named: "2")!),
                CellData(title: "Medium", featureImage: UIImage(named: "1")!)

            ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.backgroundColor  = .secondarySystemBackground
        navigationItem.title = "Spot"
        view.backgroundColor = UIColor.init(_colorLiteralRed: 228/255, green: 230/255, blue: 234/255, alpha: 1)
        
        
        setUpTableView()
    }
    
    fileprivate func setUpTableView() {
        tableView.register(CardCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    //CELL
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! CardCell
        let section = sections[indexPath.section]
        let cellData = section.data[indexPath.row]
        cell.cellData = cellData
        cell.animate()
        return cell
    }
    
    //SECTIONS & ROWS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].open {
            return 0
        }
        return sections[section].data.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240 
    }
    
    // HEADERS
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.tag = section
        button.setTitle("close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)
        return button
    }
    
    @objc fileprivate func openSection(button: UIButton) {
        //print("button.tag:", button.tag)
        let section = button.tag
        var indexPaths = [IndexPath]()
        
        for row in sections[section].data.indices {
            let indexPathToDelete = IndexPath(row: row, section: section)
            indexPaths.append(indexPathToDelete)
        }
        
        let isOpen = sections[section].open
        sections[section].open = !isOpen
        button.setTitle(isOpen ? "open" : "close", for: .normal)
        
        if isOpen {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        
    }
}

