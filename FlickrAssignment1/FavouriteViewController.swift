//
//  FavouriteViewController.swift
//  FlickrAssignment1
//
//  Created by admin on 20/03/2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    var favouriteImage: [FlickrEntity] = []
    

    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        favouriteCollectionView.dataSource = self
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        favouriteImage = FlickrEntity.getEntity(moc: CoreDataManager.shared.persistentContainer.viewContext)
            favouriteCollectionView.reloadData()
        }
    
}

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! favouriteCollectionViewCell
        
        let farm = favouriteImage[indexPath.row].farm
        let server = favouriteImage[indexPath.row].server ?? ""
        let id = favouriteImage[indexPath.row].id ?? ""
        let secret = favouriteImage[indexPath.row].secret ?? ""
        
        let imageReturnedURL = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
        favCell.favouriteImage.downLoadImage(owner: imageReturnedURL)

        return favCell
    }
}


    
    
    

