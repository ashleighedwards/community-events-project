//
//  AddEventViewModel.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 27/07/2022.
//

import Foundation
import CoreData

class AddEventViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var eventDate: String = ""
    @Published var eventTime: String = ""
    @Published var contactInfo: String = ""
    @Published var longitude: String = ""
    @Published var latitude: String = ""
    @Published var details: String = ""
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addEvent() {
        do {
            let event = EventList(context: context)
            event.name = name
            event.address = address
            event.eventDate = eventDate
            event.eventTime = eventTime
            event.contactInfo = contactInfo
            event.longitude = longitude
            event.latitude = latitude
            event.details = details
            try event.save()
        } catch {
            print(error)
        }
    }
}

