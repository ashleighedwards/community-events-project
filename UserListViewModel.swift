//
//  UserViewModel.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 27/07/2022.
//

import Foundation
import CoreData

class UserListViewModel: NSObject, ObservableObject {
    @Published var users = [UserViewModel]()
    
    private let fetchedResultsController: NSFetchedResultsController<User>
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: User.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let users = fetchedResultsController.fetchedObjects else {
                return
            }
            self.users = users.map(UserViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func deleteUser(userId: NSManagedObjectID) {
        do {
            guard let user = try context.existingObject(with: userId) as? User else {
                return
            }
            
            try user.delete()
        } catch {
            print(error)
        }
    }
}

extension UserListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let users = controller.fetchedObjects as? [User] else {
            return
        }
        
        self.users = users.map(UserViewModel.init)
    }
}

struct UserViewModel: Identifiable {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var id: NSManagedObjectID {
        user.objectID
    }
    
    var address: String {
        user.address ?? ""
    }
}
