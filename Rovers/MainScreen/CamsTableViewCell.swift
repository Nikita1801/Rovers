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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let camButton: UIButton = {
        let button = UIButton()
        if let font = UIFont(name: "Helvetica Bold", size: 16){
            button.titleLabel?.font = font
        }
        button.addTarget(self, action: #selector(camButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.customBlack
        
        return button
    }()
    
    @objc func camButtonTapped(){
        print(camButton.titleLabel)
    }
    
    func set(camName: String){
        camButton.setTitle(camName, for: .highlighted)
        print(camButton.titleLabel)
    }
    
    func set(camsPhotoArray: [CamsModel]){
        self.photoArray = camsPhotoArray
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
    
    var didLayout = false
    override func layoutSubviews() {
        if !self.didLayout {
            self.didLayout = true // only need to do this once
            self.photosCollectionView.reloadData()
        }
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
        
        addSubview(camButton)
        addSubview(photosCollectionView)
        
        
        setConstraints()
    }
    
    
    func setConstraints(){
        camButton.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            camButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            camButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            camButton.bottomAnchor.constraint(equalTo: photosCollectionView.topAnchor, constant: -24),
            
            photosCollectionView.topAnchor.constraint(equalTo: camButton.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photosCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
