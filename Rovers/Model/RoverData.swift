//
//  RoverData.swift
//  Rovers
//
//  Created by Никита Макаревич on 16.08.2022.
//

import Foundation

struct RoverData: Codable{
    let photos: [Photos]
}

struct Photos: Codable{
    let id: Int
    let sol: Int
    let camera: Camera
    let img_src: String
}

struct Camera: Codable{
    let name: String
}
