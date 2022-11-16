//
//  CommunityEventsMapApp.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 27/07/2022.
//

import SwiftUI

@main
struct CommunityEventsMapApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        
        WindowGroup {
            VStack {
                LoginView()
                    .environment(\.managedObjectContext,
                                  persistenceController.persistentStoreContainer.viewContext)
                
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .accentColor(.primary)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
