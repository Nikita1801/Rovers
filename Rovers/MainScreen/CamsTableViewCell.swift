//
//  CamsTableViewCell.swift
//  Rovers
//
//  Created by Никита Макаревич on 17.08.2022.
//

import UIKit

final class CamsTableViewCell: UITableViewCell {
    
    var cameraName = ""
    var photoArray: [CamsModel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        photosCollectionView.layer.borderWidth = 1
  
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
        camLabel.text = camName
        
    }
    
    func set(camsPhotoArray: [CamsModel]){
        self.photoArray = camsPhotoArray
        print("PRINT: \(photoArray)")
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
        photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoscell", for: indexPath) as! PhotosCollectionViewCell
        let photoDetails = photoArray[indexPath.row]
        collectionViewCell.set(id: photoDetails.id, sol: photoDetails.sol)
//        collectionViewCell.backgroundColor = UIColor.systemRed
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: 116)
    }
    

}


private extension CamsTableViewCell{
    
    func configureView(){
        setCollectionViewDelegates()
        
        addSubview(camLabel)
        addSubview(photosCollectionView)
        
        
        setConstraints()
    }
    
    
    func setConstraints(){
        camLabel.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            camLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            camLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            camLabel.bottomAnchor.constraint(equalTo: photosCollectionView.topAnchor, constant: -24),
            
            photosCollectionView.topAnchor.constraint(equalTo: camLabel.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photosCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
