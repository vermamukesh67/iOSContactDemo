//
//  ContactListVC.swift
//  ContactsiOSDemo
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit
import CoreData

// Tableview delegate and datasource composition

typealias TableViewDelegateDataSource = (UITableViewDelegate & UITableViewDataSource)

class ContactListVC: BaseViewController,LogoutDelegate {
    
    @IBOutlet weak var tblContacts: UITableView!
    
    private var viewModel = ContactListViewModel()
    
    // MARK: - ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        observeEvents()
        viewModel.loadAllContactData()
        self.logout()
    }
    
    // Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            self?.tblContacts.reloadData()
        }
    }
    
    /// Prepare the table view.
    private func prepareTableView() {
        ContactDisplayTableCell.registerWithTable(self.tblContacts)
    }
}

// MARK: - UITableView Delegate and DataSource

extension ContactListVC : TableViewDelegateDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sortedKeys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsForForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactDisplayTableCell! = tableView.dequeueReusableCell(withIdentifier: "ContactDisplayTableCell") as? ContactDisplayTableCell
        if let data = viewModel.getRecordBasedOnSection(section: indexPath.section, row: indexPath.row)
        {
            cell.setUpUIForContact(objContact:data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel.sortedKeys[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = viewModel.getRecordBasedOnSection(section: indexPath.section, row: indexPath.row)
        {
            self.navigateToMovieDetailsWithMovieData(data, opType: .EditContact)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Routing

extension ContactListVC
{
    
    private func navigateToMovieDetailsWithMovieData(_ contactDetails: Contact?, opType: ContactOperationType) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ContactAddEditVC") as! ContactAddEditVC
        controller.objContactDetails = contactDetails
        controller.contactOperationType = opType
        controller.delegate = self
        switch opType {
        case .AddContact:
            let objNav = ContactNavigationVC.init(rootViewController: controller)
            self.present(objNav, animated: true, completion: nil)
        case .EditContact:
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - IBAction Handling

extension ContactListVC
{
    @IBAction func btnAddContactTapped(_ sender: Any) {
        
        self.navigateToMovieDetailsWithMovieData(nil, opType: .AddContact)
    }
}

extension ContactListVC : AddEditContactDelegate
{
    func didContactAddedOrUpdated(diccContact : [String : String]?, opType : ContactOperationType)
    {
        switch opType {
        case .AddContact:
            viewModel.updateContact(diccContact: diccContact)
        case .EditContact:
            self.tblContacts.reloadData()
    }
    }
}
