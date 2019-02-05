//
//  ContactListViewModel.swift
//  ContactsiOSDemo
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import Foundation

class ContactListViewModel
{
    /// Data source for the home page table view.
    
    var diccMobileData : [String : [Contact]] = [String : [Contact]]()
    var sortedKeys : [String] = [String]()
    
    // MARK: Events
    
    var reloadTable: ()->() = { }
    
    init() {
        
    }
    
    /// Method call to inform the view model to refresh the data.
    func loadAllContactData() {
        self.prepareData()
        self.reloadTable()
    }
    
    func updateContact(diccContact : [String : String]?)
    {
        if let dicc = diccContact
        {
            if let objSavedCon = Contact.SaveContactData(dicc)
            {
                self.prepareDiccWithForSingleRecord(objSavedCon)
                self.preparekeysAndSorting()
                self.reloadTable()
            }
        }
    }
    
    /// get record based on section and row
    func getRecordBasedOnSection(section : Int, row : Int) -> Contact?
    {
        let array : [Contact] = diccMobileData[sortedKeys[section]] ?? [Contact]()
        return (array.count > row) ? array[row] : nil
    }
    
    func getNumberOfRowsForForSection(section : Int) -> Int
    {
        let array : [Contact] = diccMobileData[sortedKeys[section]] ?? [Contact]()
        return array.count
    }
    
     func prepareDiccWithForSingleRecord(_ objRecord: Contact) {
        if let firstName = objRecord.firstName
        {
            if let character = firstName.character(at: 0) {
                print("I found \(character)") // I found l
                
                if self.diccMobileData[String(character)] != nil
                {
                    var arrayData : [Contact] = self.diccMobileData[String(character)] ?? [Contact]()
                    arrayData.append(objRecord)
                    self.diccMobileData.updateValue(arrayData, forKey: String(character))
                }
                else
                {
                    var arrayData : [Contact] = [Contact]()
                    arrayData.append(objRecord)
                    self.diccMobileData.updateValue(arrayData, forKey: String(character))
                }
            }
        }
    }
    
    /// Prepare the tableDataSource
    func prepareData( )
    {
        let  tableDataSource: [Contact] = Contact.fetchAllContactData() ?? [Contact]()
        
        for (_ , objRecord) in tableDataSource.enumerated()
        {
            prepareDiccWithForSingleRecord(objRecord)
        }
    
        self.preparekeysAndSorting()
    }
    
    func preparekeysAndSorting()
    {
        let arrYears : [String] = Array(diccMobileData.keys)
        sortedKeys = arrYears.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
    }
}

// Build your own String Extension for grabbing a character at a specific position
extension String {
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
}
