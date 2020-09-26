//
//  ViewController.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class ViewController: UIViewController {

    private var lazyTable: UITableView!
    
    override func loadView() {
        print("Load View")
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = UIColor.lightText
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Country"
        self.creatListView()
    }

    private func creatListView(){
        self.lazyTable = UITableView(frame: .zero)
        self.view.addSubview(self.lazyTable)
        self.lazyTable.dataSource = self
        self.lazyTable.delegate = self
        self.lazyTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addConstraintToTableView()
        self.lazyTable.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func addConstraintToTableView(){
        
        self.lazyTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.lazyTable!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: self.lazyTable!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: self.lazyTable!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 10).isActive = true
        
        NSLayoutConstraint(item: self.lazyTable! , attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -10).isActive = true
    }

}

