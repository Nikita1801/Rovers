//
//  MainViewController.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit

var dateYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date())!


final class MainViewController: UIViewController {
    
    var camsInfoArray: [RoverModel?] = []
    var camsNames: [String] = [""]
    var sortedCamerasDict: [String: [CamsModel]] = [:]
    
    var roverManager = RoverManager()
    var camsTableView = UITableView()
    var selectedRover = "Curiosity"
    var isViewDidLoad = false
    var dateYearAgoForNetwork: String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dateYearAgo)
        roverManager.roversArrayDelegate = self
    
        preapreDateAndMakeRequest()
        
        view.backgroundColor = .white
        isViewDidLoad = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isViewDidLoad{
            //roverManager.fetchURL(roverName: selectedRover, earthDate: dateYearAgoForNetwork)
            
        }
        print(selectedRover)
        
        camsTableView.reloadData()
    }
    
    
    func preapreDateAndMakeRequest() {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-M-d"
        dateYearAgoForNetwork = dateFormater.string(from: dateYearAgo)
        roverManager.fetchURL(roverName: selectedRover, earthDate: dateYearAgoForNetwork)
    }
    
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.YYYY"
        let newDate = dateFormater.string(from: dateYearAgo)
        label.text = newDate
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
        label.text = "Curiosity"
        label.textColor = UIColor.customBlack
        label.font = UIFont(name: "Helvetica Bold", size: 34)
        
        return label
    }()
    
    private let leftArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowleft.png"), for: .normal)
        button.addTarget(self, action: #selector(decreaseDate), for: .touchUpInside)
        
        return button
    }()
    
    private let rightArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowright.png"), for: .normal)
        button.addTarget(self, action: #selector(increaseDate), for: .touchUpInside)
        
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

    func createCamsModelDict(camsInfoArray: [RoverModel?]){
        
        for photo in camsInfoArray{
            guard let photo = photo else{
                continue
            }
            let camName = photo.cameraName
            if var photosArray = sortedCamerasDict[camName]{
                photosArray.append(CamsModel(id: photo.id, sol: photo.sol, image: photo.image))
                sortedCamerasDict[camName] = photosArray
            }else{
                var photosArray : [CamsModel] = []
                photosArray.append(CamsModel(id: photo.id, sol: photo.sol, image: photo.image))
                sortedCamerasDict[camName] = photosArray
            }
            
        }
        print(sortedCamerasDict.keys)
        for key in sortedCamerasDict.keys{
            print("\(key): \(sortedCamerasDict[key]?.count)")
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedCamerasDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = camsTableView.dequeueReusableCell(withIdentifier: "camscell") as! CamsTableViewCell
        let keysArray = Array(sortedCamerasDict.keys)
        
        let currentCamName: String = keysArray[indexPath.row]
        let cameraPhotos: [CamsModel] = sortedCamerasDict[currentCamName] ?? []
        cell.set(camName: currentCamName)
        cell.set(camsPhotoArray: cameraPhotos)
        
        return cell
    }
}

private extension MainViewController{
    
    // Проверить обновляется ли UI
    @objc func decreaseDate(){

        dateYearAgo = Calendar.current.date(byAdding: .day, value: -1, to: dateYearAgo)!
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.YYYY"
        let decreasedDate = dateFormater.string(from: dateYearAgo)
        dateLabel.text = decreasedDate
        
        let dateDormaterForNetwork = DateFormatter()
        dateDormaterForNetwork.dateFormat = "YYYY-M-d"
        let decreasedDateForNetwork = dateDormaterForNetwork.string(from: dateYearAgo)
        roverManager.fetchURL(roverName: selectedRover, earthDate: decreasedDateForNetwork)

    }
    
    @objc func increaseDate(){

        dateYearAgo = Calendar.current.date(byAdding: .day, value: +1, to: dateYearAgo)!
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.YYYY"
        let decreasedDate = dateFormater.string(from: dateYearAgo)
        dateLabel.text = decreasedDate
        
        let dateDormaterForNetwork = DateFormatter()
        dateDormaterForNetwork.dateFormat = "YYYY-M-d"
        let decreasedDateForNetwork = dateDormaterForNetwork.string(from: dateYearAgo)
        roverManager.fetchURL(roverName: selectedRover, earthDate: decreasedDateForNetwork)
    }
    
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

// MARK: SettingsProtocol
extension MainViewController: SettingsDelegate{
    
    func fetchSelectedRover(selectedRoverName: String) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-M-d"
        dateYearAgoForNetwork = dateFormater.string(from: dateYearAgo)
        
        selectedRover = selectedRoverName
        print("SELECTED ROVER IS: \(selectedRover)")
        roverManager.fetchURL(roverName: selectedRover, earthDate: dateYearAgoForNetwork)
        DispatchQueue.main.async {
            self.roverName.text = selectedRoverName
            self.camsTableView.reloadData()
        }

    }
}

// MARK: RoverManagerProtocol
extension MainViewController: RoverManagerDelegate{
    func didUpdateRoverInfo(_ roverManager: RoverManager, roversArray: [RoverModel?]) {
        
        camsInfoArray = roversArray
        createCamsModelDict(camsInfoArray: camsInfoArray)
        
        
        DispatchQueue.main.async {
            self.configureTableView()
            self.configureView()
            self.camsTableView.reloadData()
        }
    }
    
}
