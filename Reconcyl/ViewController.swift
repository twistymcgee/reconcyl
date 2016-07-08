//
//  ViewController.swift
//  Reconcyl
//
//  Created by Corey Mosher on 2016-07-03.
//  Copyright © 2016 Corey Mosher. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var welcomeLabel: NSTextField!
    @IBOutlet weak var accountPopUpBtn: NSPopUpButton!
    
    @IBAction func handleWelcome(sender: AnyObject) {
        welcomeLabel.stringValue = "Hello \(nameTextField.stringValue)!"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        clearAccounts()
        seedPerson("Visa")
        seedPerson("MasterCard")
        fetch()
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func seedPerson(name: String) {
        
        // create an instance of our managedObjectContext
        let moc = DataController().managedObjectContext
        
        // we set up our entity by selecting the entity and context that we're targeting
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Account", inManagedObjectContext: moc) as! Account
        
        // add our data
        entity.setValue(name, forKey: "name")
        
        // we save our entity
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func clearAccounts() {
        let moc = DataController().managedObjectContext
        let accountFetch = NSFetchRequest(entityName: "Account")
        
        do {
            let result = try moc.executeFetchRequest(accountFetch)
            for account: AnyObject in result {
                moc.deleteObject(account as! NSManagedObject)
            }
            try moc.save()
            
        } catch {
            fatalError("Failed to fetch person: \(error)")
        }
    }
    
    func fetch() {
        let moc = DataController().managedObjectContext
        let accountFetch = NSFetchRequest(entityName: "Account")
        
        do {
            let result = try moc.executeFetchRequest(accountFetch)
            for account in result {
                print(account.name!)
                accountPopUpBtn.addItemWithTitle(account.name)
            }
            
        } catch {
            fatalError("Failed to fetch person: \(error)")
        }
    }



}

