//
//  PhotoCell.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    func setup(photo: Photos?){
        photoImage.sd_setImage(with: URL(string: photo?.url ?? ""), placeholderImage: UIImage(named: ""))
    }
}
