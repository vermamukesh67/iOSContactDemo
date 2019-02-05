//
//  ParentNavigationControllerVC.swift
//  ContactsiOSDemo
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit

class ParentNavigationControllerVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Setup Navigation
    
    func setLargeStyleNavigationBar(isTrue : Bool)
    {
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = isTrue
        } else {
            // Fallback on earlier versions
        }
    }

}
