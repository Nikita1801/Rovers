//
//  SettingsViewController.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit

protocol SettingsDelegate: AnyObject{
    func fetchSelectedRover(selectedRoverName: String)
}

final class SettingsViewController: UIViewController {
    
    var roverDelegate: SettingsDelegate?
    
    let rovers = ["Spirit", "Opportunity","Curiosity", "Perseverance"]
    var roverTableView = UITableView()
    var selectedRover = "Curiosity"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureTableView()
        configureView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
    }
    func configureTableView(){
        view.addSubview(roverTableView)
        setTableViewDelegates()
        roverTableView.register(RoverTableViewCell.self, forCellReuseIdentifier: "cell")
        roverTableView.rowHeight = 50
        
    }
    
    func setTableViewDelegates() {
        roverTableView.delegate = self
        roverTableView.dataSource = self
    }
    
    private let headLableFirst: UILabel = {
        let label = UILabel()
        label.text = "ВЫБИРАЕМ"
        label.textColor = UIColor.customGrey
        label.font = UIFont(name: "Helvetica Bold", size: 11)
        
        return label
    }()
    
    private let headLableSecond: UILabel = {
        let label = UILabel()
        label.text = "Марсоходы"
        label.textColor = UIColor.customBlack
        label.font = UIFont(name: "Helvetica Bold", size: 34)
        
        return label
    }()
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rovers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roverTableView.dequeueReusableCell(withIdentifier: "cell") as! RoverTableViewCell
        cell.accessoryView = CheckMarkView.init()
        cell.accessoryView?.isHidden = true
        let roverName = rovers[indexPath.row]
        cell.set(roverName: roverName)
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        roverTableView.cellForRow(at: indexPath)?.accessoryView?.isHidden = false
        selectedRover = rovers[indexPath.row]
        print(selectedRover)
        roverDelegate?.fetchSelectedRover(selectedRoverName: selectedRover)

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        roverTableView.cellForRow(at: indexPath)?.accessoryView?.isHidden = true
        
    }
    
}

private extension SettingsViewController{
    
    func configureView(){
        view.addSubview(headLableFirst)
        view.addSubview(headLableSecond)
        view.addSubview(roverTableView)
        
        setConstraints()
    }
    
    func setConstraints(){
        roverTableView.translatesAutoresizingMaskIntoConstraints = false
        headLableFirst.translatesAutoresizingMaskIntoConstraints = false
        headLableSecond.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headLableFirst.topAnchor.constraint(equalTo: view.topAnchor, constant: 86),
            headLableFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headLableFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headLableFirst.bottomAnchor.constraint(equalTo: headLableSecond.topAnchor, constant: -10),
            
            headLableSecond.topAnchor.constraint(equalTo: headLableFirst.bottomAnchor),
            headLableSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headLableSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headLableSecond.bottomAnchor.constraint(equalTo: roverTableView.topAnchor, constant: -41),
            
            roverTableView.topAnchor.constraint(equalTo: headLableSecond.bottomAnchor),
            roverTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            roverTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}
