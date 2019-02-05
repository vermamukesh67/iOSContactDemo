//
//  ContactDetailViewModel.swift
//  ContactsiOSDemo
//
//  Created by Verma Mukesh on 01/02/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import Foundation

class ContactDetailViewModel
{
    func ValidateDetailsScreen(strFName : String?, strlastName : String?, strMo : String?) -> (Bool, String)
    {
        let trimmedFName = strFName?.trimmingCharacters(in: .whitespacesAndNewlines)
         let trimmedLName = strlastName?.trimmingCharacters(in: .whitespacesAndNewlines)
         let trimmedMo = strMo?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedFName == nil || trimmedFName?.count == 0
        {
            return (false, "Please enter first name")
        }
        else if trimmedLName == nil || trimmedLName?.count == 0
        {
            return (false, "Please enter last name")
        }
        else if trimmedMo == nil || trimmedMo?.count == 0
        {
            return (false, "Please enter mobile number")
        }
        else if trimmedMo!.count < 10
        {
            return (false, "Entered mobile number should be atleast 10 digit")
        }
        return (true, "")
    }
}
