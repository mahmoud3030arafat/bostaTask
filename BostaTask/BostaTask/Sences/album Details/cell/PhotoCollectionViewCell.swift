//
//  PhotoCollectionViewCell.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    //Outlets
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with data: Photo) {
        loadImage(from: data.imageUrl, into: photo)
    }
    
    private func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Fetch the image data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to convert data to image")
                return
            }
            
            // Update the UIImageView on the main thread
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
    
}




