//
//  ProfileViewController.swift
//  Bosta_Task
//
//  Created by Mohamed Elkazzaz on 07/09/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var profileViewModel: ProfileViewModel = ProfileViewModel()
    var albumViewModel: AlbumsViewModel = AlbumsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
        
        
        profileViewModel.getUsers(endPoint: "users/2")
        
        profileViewModel.bindingData = { users, error in
            DispatchQueue.main.async {
                self.nameLabel.text = users?.name
                self.addressLabel.text = "\(users?.address?.city ?? ""), \(users?.address?.street ?? ""), \(users?.address?.suite ?? ""), \(users?.address?.zipcode ?? "")"
            }
        
        if let error = error{
            print(error.localizedDescription)
        }
    }
        
        albumViewModel.getAlbums(endPoint: "albums")
        
        albumViewModel.bindingData = { albums, error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
        if let error = error{
            print(error.localizedDescription)
        }
            
        }
            
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Albums"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.getAlbums()?.count ?? 0
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! UserAlbumsCell
        cell.selectionStyle = .none
        cell.setup(album: albumViewModel.getAlbums(indexPath: indexPath))
//        cell.userAlbumNameLabel.text = "Album"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stoaryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = stoaryBoard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
//        vc.id = petsViewModel.petsArray?[indexPath.row].id ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
