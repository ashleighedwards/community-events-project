//
//  DetailsListViewModel.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 29/07/2022.
//

import Foundation
import CoreData

class DetailsListViewModel: NSObject, ObservableObject {
    @Published var details = [DetailsViewModel]()
    
    private let fetchedResultsController: NSFetchedResultsController<Details>
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: Details.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let details = fetchedResultsController.fetchedObjects else {
                return
            }
            self.details = details.map(DetailsViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func deleteDetails(userId: NSManagedObjectID) {
        do {
            guard let detail = try context.existingObject(with: userId) as? Details else {
                return
            }
            
            try detail.delete()
        } catch {
            print(error)
        }
    }
}

extension DetailsListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let details = controller.fetchedObjects as? [Details] else {
            return
        }
        
        self.details = details.map(DetailsViewModel.init)
    }
}

struct DetailsViewModel: Identifiable {
    private var details: Details
    
    init(details: Details) {
        self.details = details
    }
    
    var id: NSManagedObjectID {
        details.objectID
    }
    
    var fullName: String {
        details.fullName ?? ""
    }
}
