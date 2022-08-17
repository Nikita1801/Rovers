//
//  CheckMarkView.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit

final class CheckMarkView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let img = UIImage(named: "checkmark.png")
        let imageView: UIImageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 350, y: 15, width: 20, height: 20)
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
