//
//  BaseViewController.swift
//  ContactsiOSDemo
//
//  Created by Verma Mukesh on 04/02/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit

protocol LogoutDelegate {
    func logout()
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LogoutDelegate where Self : BaseViewController
{
    func logout() {
        print("logout")
    }
}
