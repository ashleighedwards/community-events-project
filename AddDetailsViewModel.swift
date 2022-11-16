//
//  AddDetailsEventViewModel.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 29/07/2022.
//

import Foundation
import CoreData

class AddDetailsViewModel: ObservableObject {
    
    @Published var fullName: String = ""
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addDetails() {
        do {
            let detail = Details(context: context)
            detail.fullName = fullName
            try detail.save()
        } catch {
            print(error)
        }
    }
}

