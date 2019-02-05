//
//  Contact+CoreDataProperties.swift
//  ContactsiOSDemo
//
//  Created by Verma Mukesh on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Contact {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }
    
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var mobileNumber: String?
    
    // MARK: Coredata Insert, Update , Fetch methods
    
    /*
     This function is responsible for insert and update. First it check the same record by using Contact Number as unique value , if record exist then it update the existing record otherwise insert the Contact data (objContact) into database
     Returns the Contact after inserting or updating
     */
    public static  func SaveContactData(_ diccContact: [String : String]) -> Contact? {
        
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = AppDelegate.persistentContainer.viewContext
        
        if let mobile = diccContact["mobileNumber"] {
            
            
            // access managedcontent instance
            // Check data already exist in database
            let objContactData = fetchContactDataByMobile(mobile)
            
            if let objContact = objContactData{
                
                // updating the data
                
                objContact.firstName = diccContact["fName"] ?? ""
                objContact.lastName = diccContact["lName"] ?? ""
                
                // 4
                do {
                    try managedContext.save()
                    return objContact
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            else
            {
                // inserting the data
                let entity =
                    NSEntityDescription.entity(forEntityName: "Contact",
                                               in: managedContext)!
                
                let objNewContact = NSManagedObject(entity: entity,
                                                    insertInto: managedContext)
                objNewContact.setValue(diccContact["fName"], forKeyPath: "firstName")
                objNewContact.setValue(diccContact["lName"], forKeyPath: "lastName")
                objNewContact.setValue(diccContact["mobileNumber"], forKeyPath: "mobileNumber")
                // 4
                do {
                    try managedContext.save()
                    return objNewContact as? Contact
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        
        return nil
    }
    
    /*
     This function is responsible for fetching the unique record by considering Contact name (strContactName) as unique key
     Returns the ContactData if found
     */
    public static func fetchContactDataByMobile(_ strContactName:String) -> Contact? {
        
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = AppDelegate.persistentContainer.viewContext
        // create the fetch request
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Contact")
        fetchRequest.returnsObjectsAsFaults = false
        // fetch unique record using predicate
        
        fetchRequest.predicate = NSPredicate(format: "mobileNumber == %@", strContactName)
        
        // execute the fetch request
        do {
            let  arrObjContact = try managedContext.fetch(fetchRequest)
            if arrObjContact.count>0 {
                let objContact = arrObjContact.first
                
                return objContact as? Contact
            }
            else
            {
                return nil;
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil;
    }
    
    /*
     This function is responsible for fetching all the data
     return the array of ContactData
     */
    public static func fetchAllContactData() -> [Contact]? {
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = AppDelegate.persistentContainer.viewContext
        // create the fetch request
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Contact")
        fetchRequest.returnsObjectsAsFaults = false
        // excute the fetch request and return the data
        do {
            let  arrContacts = try managedContext.fetch(fetchRequest)
            return arrContacts as? [Contact]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil;
    }
    
}

