//
//  MemeDetailViewController.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/23/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController{
    
    @IBOutlet weak var fullMemeView: UIImageView!
    
    var meme : Meme!
    var memeIndex: Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController?.tabBar.hidden = true
        
        fullMemeView.image = meme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
        
    @IBAction func editMeme(sender: AnyObject) {
        let editorController = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        editorController.memeIndex = memeIndex
        editorController.meme = meme
        
        presentViewController(editorController, animated: true, completion: nil )
    }
    
}


