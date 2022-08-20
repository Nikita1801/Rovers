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

        
        configureView()
        photosCollectionView.reloadData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var camButton: UIButton = {
        let button = UIButton()
        if let font = UIFont(name: "Helvetica Bold", size: 16){
            button.titleLabel?.font = font
        }
        button.addTarget(self, action: #selector(camButtonTapped), for: .touchUpInside)
//        button.backgroundColor = UIColor.customBlack
        button.setTitle(cameraName, for: .normal)
        button.setTitleColor(UIColor.customBlack, for: .normal)
        
        return button
    }()
    
    @objc func camButtonTapped(){
        print(camButton.titleLabel)
    }
    
    func set(camName: String){
        cameraName = camName
        camButton.setTitle(camName, for: .normal)
        print(camButton.titleLabel)
    }
    
    func set(camsPhotoArray: [CamsModel]){
        self.photoArray = camsPhotoArray
        photosCollectionView.reloadData()
    }
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
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
        collectionViewCell.set(id: photoDetails.id, sol: photoDetails.sol, image: photoDetails.image)
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: 116)
    }
    

}


private extension CamsTableViewCell{
    
    func configureView(){
        setCollectionViewDelegates()
        
        contentView.addSubview(camButton)
        contentView.addSubview(photosCollectionView)
        
        
        setConstraints()
    }
    
    
    func setConstraints(){
        camButton.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            camButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            camButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            camButton.bottomAnchor.constraint(equalTo: photosCollectionView.topAnchor, constant: -12),
            
            photosCollectionView.topAnchor.constraint(equalTo: camButton.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photosCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
