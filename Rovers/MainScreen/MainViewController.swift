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
    
    var roverManager = RoverManager()
    var settingsViewController = SettingsViewController()
    var camsTableView = UITableView()
    var selectedRover = "Spirit"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        configureTableView()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        settingsViewController.roverDelegate = self
        roverManager.fetchURL(roverName: selectedRover, earthDate: "2022-8-10")
        print(selectedRover)
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
        view.addSubview(camsTableView)
        setTableViewDelegates()
        camsTableView.register(RoverTableViewCell.self, forCellReuseIdentifier: "camscell")
        camsTableView.rowHeight = 160
        
    }
    
    func setTableViewDelegates(){
        camsTableView.delegate = self
        camsTableView.dataSource = self
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = camsTableView.dequeueReusableCell(withIdentifier: "camscell") as! CamsTableViewCell
        
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
        
        setConstraints()
    }
    
    func setConstraints(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        roverName.translatesAutoresizingMaskIntoConstraints = false
        leftArrowButton.translatesAutoresizingMaskIntoConstraints = false
        rightArrowButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: 8),
            
            horizontalStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            roverName.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            roverName.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            roverName.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            
            leftArrowButton.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            leftArrowButton.trailingAnchor.constraint(equalTo: rightArrowButton.leadingAnchor, constant: 16),
            leftArrowButton.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            
            rightArrowButton.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            rightArrowButton.leadingAnchor.constraint(equalTo: leftArrowButton.trailingAnchor),
            rightArrowButton.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor),
            rightArrowButton.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor)
        ])
    }
}

extension MainViewController: SettingsDelegate{
    
    func fetchSelectedRover(selectedRoverName: String) {
        selectedRover = selectedRoverName
    }
    
    
}
