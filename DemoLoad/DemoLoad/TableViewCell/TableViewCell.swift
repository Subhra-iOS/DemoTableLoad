//
//  TableViewCell.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import  UIKit

class  TableViewCell: UITableViewCell{
    
    var imageUrl: String?
    var taskId: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(containerView)
        self.setContainerViewContraint()
        containerView.addSubview(imageHolderView)
        self.setImageHolderContarint()
        imageHolderView.addSubview(iconImageView)
        self.setImageIconContarint()
        imageHolderView.addSubview(activityLoader)
        self.setActivityLoaderConstraint()
        containerView.addSubview(nameLabel)
        containerView.addSubview(detailedLabel)
        self.setNameLabelConstraint()
        self.setDetailedLabelContarint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let imageHolderView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.backgroundColor = UIColor(red: (224.0/255.0), green: (224.0/255.0), blue: (224.0/255.0), alpha: 1.0)
        img.clipsToBounds = true
        img.layer.cornerRadius = 5
        return img
    }()
    
    let  activityLoader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.backgroundColor = UIColor.yellow
        return label
    }()
    
    let detailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor =  UIColor.lightText
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.backgroundColor = UIColor.systemBlue
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
       // view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
}
