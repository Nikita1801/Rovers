//
//  RoverManager.swift
//  Rovers
//
//  Created by Никита Макаревич on 16.08.2022.
//

import Foundation



final class RoverManager{
    // https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?&earth_date=2022-8-10&api_key=Uls3MlNWdgwJ9Vzmw8kXbdUdvRixsSz72ulUD3AL

    let nasaURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    let apiKey = "Uls3MlNWdgwJ9Vzmw8kXbdUdvRixsSz72ulUD3AL"
    
    
    func getData(roverName: String, earthDate: String, comletionHandler:@escaping ([RoverModel?], Error?) -> Void){
        
        let finalURL = "\(nasaURL)\(roverName)/photos?&earth_date=\(earthDate)&api_key=\(apiKey)"
        
        if let url = URL(string: finalURL){
            print(url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("Error")
                    return
                }
                if let safeData = data{
                    let roverInfo = self.parseJSON(safeData)
                    // delegate updateUI
                    
//                    print(self.roversArrayDelegate?.didUpdateRoverInfo(self, roversArray: roverInfo))
                    comletionHandler(roverInfo, nil)
                    //print(roverInfo)
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ roverInfo: Data) -> [RoverModel?]{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(RoverData.self, from: roverInfo)
            let roverCamsArray: [Photos] = decodedData.photos
//            print(roverCamsArray.map{map(rover: $0)})
            return roverCamsArray.map{map(rover: $0)}
        }
        catch{
            print("Error while parsing")
            return [nil]
        }
    }
    
    
    func map(rover: Photos) -> RoverModel{
        return RoverModel.init(id: rover.id, sol: rover.sol, cameraName: rover.camera.name, image: rover.img_src)
    }
}
