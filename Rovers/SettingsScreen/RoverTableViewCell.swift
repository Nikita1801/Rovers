//
//  RoverTableViewCell.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit

class RoverTableViewCell: UITableViewCell{
    
    var roverNameLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        roverNameLable.font = UIFont(name: "Helvetica", size: 16)
        roverNameLable.highlightedTextColor = UIColor.customPurple
        addSubview(roverNameLable)
//        addSubview(checkmark)
        setConstraints()
    }
//    private let checkmark : UIView = {
//        let img = UIImage(named: "checkmark.png")
//        let imageView: UIImageView = UIImageView(image: img)
//        imageView.isHidden = true
//
//        return imageView
//    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(roverName: String){
        roverNameLable.text = roverName
    }
    
    func setConstraints(){
        roverNameLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roverNameLable.topAnchor.constraint(equalTo: topAnchor),
            roverNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            roverNameLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            roverNameLable.bottomAnchor.constraint(equalTo: bottomAnchor),

//            checkmark.topAnchor.constraint(equalTo: topAnchor),
//            checkmark.leadingAnchor.constraint(equalTo: roverNameLable.trailingAnchor),
//            checkmark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
//            checkmark.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
