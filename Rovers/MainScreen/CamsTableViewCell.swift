//
//  CamsTableViewCell.swift
//  Rovers
//
//  Created by Никита Макаревич on 17.08.2022.
//

import UIKit

final class CamsTableViewCell: UITableViewCell {
    
    var roverManager = RoverManager()
    var cameraName = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // Возможно стоит перенести в didUpdateRoverInfo
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let camLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Bold", size: 16)
        
        return label
    }()
    
    func set(camName: String){
        cameraName = camName
        camLabel.text = camName
    }
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photoscell")
        
        return collectionView
    }()
    
    func setCollectionViewDelegates() {
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
    }
    
}

extension CamsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        while cameraName == roverModel.name{
//          
//       }
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoscell", for: indexPath) as! PhotosCollectionViewCell
        
        return collectionViewCell
    }
}


private extension CamsTableViewCell{
    
    func configureView(){
        addSubview(camLabel)
        addSubview(photosCollectionView)
        
        setConstraints()
    }
    
    
    func setConstraints(){
        camLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            camLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            camLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
