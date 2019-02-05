//
//  CoreDataManager.swift
//  ReusableTableViewCell
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import Foundation
import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    /// Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    /// Registers the Nib with the provided table
    public static func registerWithTable(_ table: UITableView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        table.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
}


