//
//  FlickrData.swift
//  FlickrAssignment1
//
//  Created by admin on 21/03/2022.
//

import Foundation
import CoreData

extension FlickrEntity {
    
    static func saveEntity(note:String, moc:NSManagedObjectContext){
        
        let dataEntity = NSEntityDescription.insertNewObject(forEntityName: "FlickrData", into: moc) as! FlickrEntity
        
        dataEntity.secret = note
        dataEntity.id = note
        dataEntity.server = note
        dataEntity.farm =

    }
    
    
    static func getEntity(moc:NSManagedObjectContext) -> [FlickrEntity] {
        
        let fr = FlickrEntity.fetchRequest()
        
        do {
          let entities = try moc.fetch(fr)
           return entities
        }catch {
            
            return []
        }
        
    }
}
