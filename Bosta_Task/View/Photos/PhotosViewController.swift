//
//  PhotosViewController.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosViewModel: PhotosViewModel = PhotosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        photosViewModel.getPhotos(endPoint: "photos")
        photosViewModel.bindingData = { photos, error in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        
        if let error = error{
            print(error.localizedDescription)
        }
            
        }
        
    }

}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.getPhotos()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        cell.setup(photo: photosViewModel.getPhotos(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width / 3 // Display three images in a row
            let height = width // Maintain a square aspect ratio
            return CGSize(width: width, height: height)
        }
    
    
}
