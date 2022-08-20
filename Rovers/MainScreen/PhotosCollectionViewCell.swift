//
//  PhotosCollectionViewCell.swift
//  Rovers
//
//  Created by Никита Макаревич on 17.08.2022.
//

import UIKit
import Nuke

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let photoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        
        return image
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 13)
        label.textColor = UIColor.customBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let solLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Bold", size: 8)
        label.textColor = UIColor.customGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    func set(id: Int, sol: Int, image: String){
        idLabel.text = "id #\(id)"
        solLabel.text = "СОЛ #\(sol)"
        let url = image
        Nuke.loadImage(with: url, into: photoImage)

    }
    
    func configureView(){
        addSubview(photoImage)
        addSubview(idLabel)
        addSubview(solLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImage.frame = CGRect(x: 0,
                                  y: 4,
                                  width: contentView.frame.size.width,
                                  height: 76)
        
        idLabel.frame = CGRect(x: 0,
                                  y: 84,
                                  width: contentView.frame.size.width,
                                  height: 16)
        
        solLabel.frame = CGRect(x: 0,
                                  y: 98,
                                  width: contentView.frame.size.width,
                                  height: 16)
    }
    
    
    
    
}
