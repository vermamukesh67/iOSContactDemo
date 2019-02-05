//
//  ContactAddEditVC.swift
//  ContactsiOSDemo
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit

protocol AddEditContactDelegate {
    func didContactAddedOrUpdated(diccContact : [String : String]?, opType : ContactOperationType)
}

public enum ContactOperationType
{
    case AddContact
    case EditContact
}

class ContactAddEditVC: UITableViewController {
    
    // MARK: - IBOutlet
    
    var viewModel = ContactDetailViewModel()
    
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    var delegate: AddEditContactDelegate?
    var objContactDetails : Contact?
    
    var contactOperationType: ContactOperationType = .AddContact
    
    // MARK: - ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
}

// MARK: - Setup UI

extension ContactAddEditVC
{
    private func setUpUI()
    {
        switch contactOperationType {
        case .AddContact:
            self.title = "Add New Contact"
            // Adding left bar button to cancel the add/edit operation
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(btnCancelTapped))
            
        case .EditContact:
            self.title = "Edit Contact"
            // Update User Interface
            txtFirstName.text = objContactDetails?.firstName
            txtLastName.text = objContactDetails?.lastName
            txtMobile.text = objContactDetails?.mobileNumber
        }
       
        // Adding right bar button to update or add new the content
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(btnSaveTapped))
        
        // Add Gesture to dismiss the keyboard when tapped outside in screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
}

// MARK: - IBAction Handling

extension ContactAddEditVC
{
    @objc func btnCancelTapped(_ id : Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnSaveTapped(_ id : Any) {
        
        let validation = viewModel.ValidateDetailsScreen(strFName: txtFirstName.text, strlastName: txtLastName.text, strMo: txtMobile.text)
        
        if validation.0 {
            guard let fName = txtFirstName.text else { return }
            guard let lName = txtLastName.text else { return }
            guard let mobile = txtMobile.text else { return }
            
            // Update Contact
            objContactDetails?.firstName = fName
            objContactDetails?.lastName = lName
            objContactDetails?.mobileNumber = mobile
            
            guard let delegate = delegate else { return }
            // Notify Delegate
            delegate.didContactAddedOrUpdated(diccContact: ["fName" : fName, "lName": lName, "mobileNumber" : mobile], opType : contactOperationType)
            
            switch contactOperationType {
            case .AddContact:
                self.dismiss(animated: true, completion: nil)
                
            case .EditContact:
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
                navigationController?.popViewController(animated: true)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: validation.1, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)

        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.view.endEditing(true)
    }
}

// MARK: - UITextfield Delegate

extension ContactAddEditVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
