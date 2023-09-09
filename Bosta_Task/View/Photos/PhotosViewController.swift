//
//  PhotosViewController.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import UIKit
import RxSwift
import RxCocoa


class PhotosViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosViewModel: PhotosViewModel = PhotosViewModel(album: nil)
    var navTitle = ""
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
       self.title = photosViewModel.album?.title
        
        photosViewModel.getPhotosArray()
        
        photosViewModel.photoSubject
          .subscribe(onNext: { [weak self] photos in
              DispatchQueue.main.async {
                  self?.collectionView.reloadData()
              }
          })
          .disposed(by: disposeBag)

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
            print("###################\(width)")
            print(width,height)
            return CGSize(width: width, height: height)
        }
    
    
}

extension PhotosViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        photosViewModel.search(with: searchText)
        
    }
}

