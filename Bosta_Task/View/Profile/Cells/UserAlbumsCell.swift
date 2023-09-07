//
//  UserAlbumsCell.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import UIKit

class UserAlbumsCell: UITableViewCell {
    @IBOutlet weak var userAlbumNameLabel: UILabel!
   
    
    func setup(album: Album?){
        userAlbumNameLabel.text = album?.title
    }

}
