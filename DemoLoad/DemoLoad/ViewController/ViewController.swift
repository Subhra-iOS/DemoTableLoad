//
//  ViewController.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class ViewController: UIViewController {

    public private(set) var lazyTable: UITableView!
    var viewModel: ViewModel!
    
    //MARK:------Refresh Control--------//
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .gray
       
        return refreshControl
    }()
    
    override func loadView() {
        print("Load View")
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Country"
        self.creatListView()
        self.initiateViewModel()
    }

    private func creatListView(){
        self.lazyTable = UITableView(frame: .zero)
        self.view.addSubview(self.lazyTable)
        self.lazyTable.dataSource = self
        self.lazyTable.delegate = self
        self.lazyTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addConstraintToTableView()
        self.lazyTable.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.lazyTable.refreshControl = self.refreshControl
    }
    
    private func addConstraintToTableView(){
        
        self.lazyTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.lazyTable!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: self.lazyTable!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: self.lazyTable!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 10).isActive = true
        
        NSLayoutConstraint(item: self.lazyTable! , attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -10).isActive = true
    }

}

