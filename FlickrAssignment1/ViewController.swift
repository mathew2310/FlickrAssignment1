//
//  ViewController.swift
//  FlickrAssignment1
//
//  Created by admin on 20/03/2022.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: FlickrViewModel!
    
   // var networkManager : flickrNetworkClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            searchBar.delegate = self

        collectionView.dataSource = self
        viewModel = FlickrViewModel(delegate: self)
        collectionView.delegate = self
        

       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let text = searchBar.text {
                viewModel.getImage(search: text)
            }
        }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let flickrCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCell", for: indexPath) as! FlickrViewCell
       let user = viewModel.data[indexPath.row]
        
        let farmValue = user.farm
        let server = user.server
        let id = user.id
        let secretValue = user.secret
        
        let imageReturnedURL = "https://farm\(farmValue).staticflickr.com/\(server)/\(id)_\(secretValue)_m.jpg"
        
        flickrCell.flickrImage.downLoadImage(owner: imageReturnedURL)

        //https://farm2.staticflickr.com/1704/25180682049_0c83b86b32_m.jpg

        
        return flickrCell
    }
    
}

protocol Result: AnyObject{
    
    func getFinalResult()
}

extension ViewController: Result{
    
    func getFinalResult() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        //let cell = collectionView.cellForItem(at: indexPath) as! FlickrViewCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        
        FlickrEntity.saveEntity(server: viewModel.data[indexPath.row].server, id: viewModel.data[indexPath.row].id, secret: viewModel.data[indexPath.row].secret, farm: viewModel.data[indexPath.row].farm, moc: managedObjectContext)
        
        CoreDataManager.shared.saveContext()
        
    }
}

