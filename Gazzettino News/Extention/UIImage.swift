//
//  UIImage.swift
//  newsAlamofire
//
//  Created by Massimiliano on 12/06/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit


extension UIImageView {
    func downloadFromURL(url : URL, contentMode mode : UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mineType = response?.mimeType, mineType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in self.image = image}
        }.resume()
        }
    
    func downloadedFrom(link : String, contentMode mode : UIView.ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        downloadFromURL(url: url, contentMode: mode)
    }
    
    
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    }

