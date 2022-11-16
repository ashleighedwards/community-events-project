//
//  DataFactory.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 28/07/2022.
//

import Foundation


struct ImportedEvents: Identifiable {
    var name: String = ""
    var address: String = ""
    var contactInfo: String = ""
    var details: String = ""
    var eventDate: String = ""
    var eventTime: String = ""
    var longitude: String = ""
    var latitude: String = ""
    var id = UUID()
    
    init(raw: [String]) {
        name = raw[0]
        address = raw[1]
        contactInfo = raw[2]
        details = raw[3]
        eventDate = raw[4]
        eventTime = raw[5]
        longitude = raw[6]
        latitude = raw[7]
    }
}

func loadCSV(from csvName: String) -> [ImportedEvents] {
    var csvToStruct = [ImportedEvents]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return []
    }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
        
    } catch {
        print(error)
        return []
    }
    
    var rows = data.components(separatedBy: "\n")
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    rows.removeLast()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: " , ")
        if csvColumns.count == columnCount {
            let eventStruct = ImportedEvents.init(raw: csvColumns)
            csvToStruct.append(eventStruct)
        }
    }
    return csvToStruct
}
