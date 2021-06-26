//
//  DataManager.swift
//  SampleForecastApp
//
//  Created by iOS Dev on 22/06/21.
//

import UIKit
import CoreData

class DataManager: NSObject {

    /// shared is a Singleton property which returns the instance of DataManager class
    static var shared = DataManager()
    
    ///context is NSManagedObjectContext, which will used to access the Core Data db. This is to prevent the object graphs from potentially getting into an inconsistent state due to concurrent writes to the same context
    private let context : NSManagedObjectContext = {
        let context = AppDelegate.shared.persistentContainer.viewContext
        return context
    }()
    
    
    private func fetchRequestWithEntityName(_ entityName : String) -> NSFetchRequest<NSFetchRequestResult> {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        return request
    }
    
    private func delete(_ entityName : String) {
        let result = self.getRecordsFromEntity(entityName)
        for object in result! {
            guard let managedObject = object as? NSManagedObject else {break}
            self.context.delete(managedObject)
        }
    }
    
    public func getEntity(_ name : String) -> NSManagedObject {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        return managedObject
    }
       
    
    public func save(){
        do {
            try self.context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    fileprivate func getRecordsFromEntity(_ entityName : String) -> Array<Any>? {
        let request = self.fetchRequestWithEntityName(entityName)
        do {
            let result = try self.context.fetch(request)
            return result
        } catch {
            print("Failed")
            return nil
        }
    }
    
    public func fetchRecords(_ request : NSFetchRequest<NSFetchRequestResult>) -> Array<Any>? {
        do {
            let result = try self.context.fetch(request)
            return result
        }
        catch {
            return nil
        }
    }
}

extension AppDelegate {
    static var shared : AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
}
