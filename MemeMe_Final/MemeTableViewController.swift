//
//  MemeTableViewController.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/22/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var memes: [Meme]!
    
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        tableView.reloadData()
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        self.performSegueWithIdentifier("newMeme", sender: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : tableViewCell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! tableViewCell
        let memesrow = self.memes[indexPath.row]
        
        cell.label1.text = memesrow.toptext
        cell.label2.text = memesrow.bottomtext
        cell.memeView.image = memesrow.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete){
        memes.removeAtIndex(indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.endUpdates()
        }
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
        
        
    }


}
