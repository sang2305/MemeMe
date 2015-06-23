//
//  MemeTableViewController.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/22/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAButton()
    }
    
    func addAButton(){
        var addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewMeme")
        navigationItem.rightBarButtonItem = addButton
        
        navigationController!.navigationBar.barTintColor = UIColor.grayColor()
       
    }
    
    func addNewMeme(){
        self.performSegueWithIdentifier("newMeme", sender: nil)
    }

}
