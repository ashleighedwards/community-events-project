//
//  UpdateUserViewModel.swift
//  CommunityUsersMap
//
//  Created by Ashleigh Edwards on 27/07/2022.
//

import Foundation
import CoreData
import SwiftUI

class UpdateUserViewModel: ObservableObject {
    @Published var address: String = ""
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addUserDetails() {
        do {
            let user = User(context: context)
            user.address = address
            try user.save()
        } catch {
            print(error)
        }
    }
}
