//
//  MainViewController.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit

protocol SettingsDelegate: AnyObject{
    func fetchSelectedRover(selectedRoverName: String)
}

final class MainViewController: UIViewController {
    
    // Delete later
//    let camsNames = ["FHAZ", "NAVCAM", "PANCAM", "RHAZ"]
    var camsInfoArray: [RoverModel?] = []
    var camsNames: [String] = [""]
    
    var roverManager = RoverManager()
    var settingsViewController = SettingsViewController()
    var camsTableView = UITableView()
    var selectedRover = "Curiosity"
    var isViewDidLoad = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roverManager.roversArraydelegate = self
        settingsViewController.roverDelegate = self
        
        roverManager.fetchURL(roverName: selectedRover, earthDate: "2022-8-10")
        
        view.backgroundColor = .white
        isViewDidLoad = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isViewDidLoad{
            roverManager.fetchURL(roverName: selectedRover, earthDate: "2022-8-10")
        }
        print(selectedRover)
        print(camsInfoArray)
        
    }
    
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "15.08.2022"
        label.textColor = UIColor.customGrey
        label.font = UIFont(name: "Helvetica Bold", size: 11)
        
        return label
    }()
    
    private let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        
        return horizontalStackView
    }()
    
    private let roverName: UILabel = {
        let label = UILabel()
        label.text = "Spirit"
        label.textColor = UIColor.customBlack
        label.font = UIFont(name: "Helvetica Bold", size: 34)
        
        return label
    }()
    
    private let leftArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowleft.png"), for: .normal)
        
        return button
    }()
    
    private let rightArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowright.png"), for: .normal)
        
        return button
    }()
    

    override func viewDidLayoutSubviews() {
        leftArrowButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        rightArrowButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    func configureTableView(){
        setTableViewDelegates()
        camsTableView.register(CamsTableViewCell.self, forCellReuseIdentifier: "camscell")
        camsTableView.rowHeight = 160
        
    }
    
    func setTableViewDelegates(){
        camsTableView.delegate = self
        camsTableView.dataSource = self
    }
    
    func getCamNamesWithoutDuplicates(){
        for roverInfo in camsInfoArray {
            camsNames.append(roverInfo?.cameraName ?? "")
        }
        camsNames = Array(Set(camsNames)).sorted()
        camsNames.removeFirst()
        
        print("______________________________\(camsNames)")
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return camsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = camsTableView.dequeueReusableCell(withIdentifier: "camscell") as! CamsTableViewCell
        let camName = camsNames[indexPath.row]
        cell.set(camName: camName)
        
        return cell
    }
    
    
}


private extension MainViewController{
    
    func configureView(){
        view.addSubview(dateLabel)
        horizontalStackView.addSubview(roverName)
        horizontalStackView.addSubview(leftArrowButton)
        horizontalStackView.addSubview(rightArrowButton)
        view.addSubview(horizontalStackView)
        view.addSubview(camsTableView)
        
        setConstraints()
    }
    
    func setConstraints(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        roverName.translatesAutoresizingMaskIntoConstraints = false
        leftArrowButton.translatesAutoresizingMaskIntoConstraints = false
        rightArrowButton.translatesAutoresizingMaskIntoConstraints = false
        camsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -8),
            
            horizontalStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            horizontalStackView.bottomAnchor.constraint(equalTo: camsTableView.topAnchor, constant: 60),
            
            roverName.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            roverName.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
//            roverName.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            
            leftArrowButton.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            leftArrowButton.trailingAnchor.constraint(equalTo: rightArrowButton.leadingAnchor, constant: 16),
//            leftArrowButton.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            
            rightArrowButton.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            rightArrowButton.leadingAnchor.constraint(equalTo: leftArrowButton.trailingAnchor),
            rightArrowButton.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor),
            rightArrowButton.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: -26),
            
            camsTableView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            camsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            camsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            camsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: SettingsDelegate{
    
    func fetchSelectedRover(selectedRoverName: String) {
        selectedRover = selectedRoverName
        print("Fix later\(selectedRover)")    // FIX THIS DELEGATE
    }
}

extension MainViewController: RoverManagerDelegate{
    func didUpdateRoverInfo(_ roverManager: RoverManager, roversArray: [RoverModel?]) {
        
        camsInfoArray = roversArray
        getCamNamesWithoutDuplicates()
        
        DispatchQueue.main.async {
            self.configureTableView()
            self.configureView()
        }
    }
    
}
