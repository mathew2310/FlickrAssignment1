//
//  FlickrDataImage .swift
//  FlickrAssignment1
//
//  Created by admin on 21/03/2022.
//

import Foundation
import CoreData

extension FlickrEntity {
    static func saveEntity(server:String, id: String, secret: String, farm: Int, moc:NSManagedObjectContext){
        
        let flickrEntity = NSEntityDescription.insertNewObject(forEntityName: "FlickrEntity", into: moc) as! FlickrEntity
        
        flickrEntity.farm = Int16(farm)
        flickrEntity.server = server
        flickrEntity.id = id
        flickrEntity.secret = secret
    }
    
    static func getEntity(moc:NSManagedObjectContext) -> [FlickrEntity]
    {
        let fr = FlickrEntity.fetchRequest()
        
        do {
            let entity = try moc.fetch(fr)
            return entity
        }catch{
            
            print(error.localizedDescription)

            return []
        }
    }
}
