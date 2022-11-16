//
//  EventsListViewModel.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 27/07/2022.
//

import Foundation
import CoreData

@MainActor
class EventListViewModel: NSObject, ObservableObject {//responsible for displaying everything related to the events
    
    @Published var events = [EventViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<EventList> //empty/full
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: EventList.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let events = fetchedResultsController.fetchedObjects else {
                return
            }
            self.events = events.map(EventViewModel.init)
            
        } catch {
            print(error)
        }
    }
}

extension EventListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let events = controller.fetchedObjects as? [EventList] else {
            return
        }
        
        self.events = events.map(EventViewModel.init)
    }
}

extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: Date())
    }
}

extension String {
    func toDouble() -> Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0
    }
}

struct EventViewModel: Identifiable {
    private var event: EventList
    
    init(event: EventList) {
        self.event = event
    }
    
    var id: NSManagedObjectID {
        event.objectID
    }
    
    var name: String {
        event.name ?? ""
    }
    
    var address: String {
        event.address ?? ""
    }
    
    var eventDate: String {
        event.eventDate ?? ""
    }
    
    var eventTime: String {
        event.eventTime ?? ""
    }
    
    var details: String {
        event.details ?? ""
    }
    
    var contactInfo: String {
        event.contactInfo ?? ""
    }
    
    var longitude: String {
        event.longitude ?? ""
    }
    
    var latitude: String {
        event.latitude ?? ""
    }
}

