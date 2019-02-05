//
//  ContactDisplayTableCell.swift
//  ContactsiOSDemo
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit

class ContactDisplayTableCell: ReusableTableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setUpUIForContact(objContact: Contact)
    {
        guard let fName = objContact.firstName, let lName = objContact.lastName else
        {
            return
        }
        lblName.text = fName + " " + lName
        lblMobile.text = objContact.mobileNumber ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
