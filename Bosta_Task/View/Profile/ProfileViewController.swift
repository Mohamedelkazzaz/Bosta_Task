//
//  ProfileViewController.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var profileViewModel: ProfileViewModel = ProfileViewModel()
    
    private let disposeBag = DisposeBag()
    private let disposeTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
        
        
        profileViewModel.getUsers()
       
        profileViewModel.profileSubject
            .subscribe(onNext: { [weak self] profile in
                       print(profile)
                
                self?.nameLabel.text = profile?.name
                       self?.addressLabel.text = "\(profile?.address?.city ?? ""), \(profile?.address?.street ?? ""), \(profile?.address?.suite ?? ""), \(profile?.address?.zipcode ?? "")"

                   })

                   .disposed(by: disposeBag)
        

            profileViewModel.albumsSubject
              .subscribe(onNext: { [weak self] albums in
                  DispatchQueue.main.async {
                      self?.tableView.reloadData()
                  }
              })
              .disposed(by: disposeBag)

        
        profileViewModel.errorObservable
            .subscribe(onNext: { [weak self] error in
                if let error = try? error{
                    print(error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)

        
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Albums"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return profileViewModel.getAlbums()?.count ?? 0
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! UserAlbumsCell
        cell.selectionStyle = .none
        cell.setup(album: profileViewModel.getAlbums(indexPath: indexPath))

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stoaryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = stoaryBoard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController

        let viewModel = PhotosViewModel(album: profileViewModel.getAlbums(indexPath: indexPath))
        vc.photosViewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
