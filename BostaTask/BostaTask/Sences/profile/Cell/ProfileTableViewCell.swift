//
//  ProfileTableViewCell.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setup(with data: Album) {
        albumName.text = data.title
    }
    
}
