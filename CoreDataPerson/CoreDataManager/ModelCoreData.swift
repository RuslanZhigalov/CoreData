

import Foundation
import CoreData
class ModelCoresData{
    let containers: String
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    init(containers: String) {
        self.containers = containers
    }
    func tableStr(keySort: String, entityName: String)->(NSFetchedResultsController<NSFetchRequestResult>){
        let fetchResult: NSFetchedResultsController<NSFetchRequestResult> = {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let sortRequest = NSSortDescriptor(key: keySort, ascending: true)
            fetchRequest.sortDescriptors = [sortRequest]
            let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            return fetchResultController
        }()
        do{
            try fetchResult.performFetch()
        }catch{
            print(error)
        }
        return fetchResult
    }
    func startCoreData(entityForName: String)->(NSEntityDescription, NSManagedObjectContext)  {
        let entityDescription = NSEntityDescription.entity(forEntityName: entityForName, in: context)
        return (entityDescription!, context)
    }
     func deleteAll(fetchEntity: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: fetchEntity)
        
        do{
            let reuslt = try context.fetch(fetchRequest)
            for resultPerson in reuslt {
                context.delete(resultPerson as! NSManagedObject)
            }
        }catch{
            print(error)
        }
        saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containers)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Name containers \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
