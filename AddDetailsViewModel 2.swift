//
//  AddDetailsViewModel.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 30/07/2022.
//

import Foundation
import CoreData
import SwiftUI

class AddDetailsViewModel: ObservableObject {
    @Published var fullName: String = ""
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addUserDetails() {
        do {
            let detail = UserInfo(context: context)
            detail.fullName = fullName
            try detail.save()
        } catch {
            print(error)
        }
    }
}
