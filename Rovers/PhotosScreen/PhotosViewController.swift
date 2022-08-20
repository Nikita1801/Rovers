//
//  PhotosViewController.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit


final class PhotosViewController: UIViewController {
    
//    var roverManager = RoverManager()
//    var dateYearAgoForNetwork: String = ""
//    var selectedRover = ""    // GET SELECTED ROVER FROM mainVC
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureView()
//        // Do any additional setup after loading the view.
//    }
//
//    func preapreDateAndMakeRequest() {
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "YYYY-M-d"
//        dateYearAgoForNetwork = dateFormater.string(from: dateYearAgo)
//        roverManager.fetchURL(roverName: selectedRover, earthDate: dateYearAgoForNetwork)
//    }
//
//
//    private var dateLabel: UILabel = {
//        let label = UILabel()
//
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "dd.MM.YYYY"
//        let newDate = dateFormater.string(from: dateYearAgo)
//        label.text = newDate
//        label.textColor = UIColor.customGrey
//        label.font = UIFont(name: "Helvetica Bold", size: 11)
//
//        return label
//    }()
//
//    private let horizontalStackView: UIStackView = {
//        let horizontalStackView = UIStackView()
//        horizontalStackView.axis = .horizontal
//
//        return horizontalStackView
//    }()
//
//    private let roverName: UILabel = {
//        let label = UILabel()
//        label.text = "Curiosity"
//        label.textColor = UIColor.customBlack
//        label.font = UIFont(name: "Helvetica Bold", size: 34)
//
//        return label
//    }()
//
//    private let leftArrowButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "arrowleft.png"), for: .normal)
//        button.addTarget(self, action: #selector(decreaseDate), for: .touchUpInside)
//
//        return button
//    }()
//
//    private let rightArrowButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "arrowright.png"), for: .normal)
//        button.addTarget(self, action: #selector(increaseDate), for: .touchUpInside)
//
//        return button
//    }()
//
//
//    private let photosCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photoscell")
//
//        return collectionView
//    }()
//

}

private extension PhotosViewController{
    
//    @objc func decreaseDate(){
//
//        dateYearAgo = Calendar.current.date(byAdding: .day, value: -1, to: dateYearAgo)!
//
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "dd.MM.YYYY"
//        let decreasedDate = dateFormater.string(from: dateYearAgo)
//        dateLabel.text = decreasedDate
//
//        let dateDormaterForNetwork = DateFormatter()
//        dateDormaterForNetwork.dateFormat = "YYYY-M-d"
//        let decreasedDateForNetwork = dateDormaterForNetwork.string(from: dateYearAgo)
//        roverManager.fetchURL(roverName: selectedRover, earthDate: decreasedDateForNetwork)
//
//    }
//
//    @objc func increaseDate(){
//
//        dateYearAgo = Calendar.current.date(byAdding: .day, value: +1, to: dateYearAgo)!
//
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "dd.MM.YYYY"
//        let decreasedDate = dateFormater.string(from: dateYearAgo)
//        dateLabel.text = decreasedDate
//
//        let dateDormaterForNetwork = DateFormatter()
//        dateDormaterForNetwork.dateFormat = "YYYY-M-d"
//        let decreasedDateForNetwork = dateDormaterForNetwork.string(from: dateYearAgo)
//        roverManager.fetchURL(roverName: selectedRover, earthDate: decreasedDateForNetwork)
//    }
//
//    func configureView(){
//        view.addSubview(dateLabel)
//        horizontalStackView.addSubview(roverName)
//        horizontalStackView.addSubview(leftArrowButton)
//        horizontalStackView.addSubview(rightArrowButton)
//        view.addSubview(horizontalStackView)
////        view.addSubview(camsTableView)
//
//        setConstraints()
//    }
//
//    func setConstraints(){
//
//    }
}
