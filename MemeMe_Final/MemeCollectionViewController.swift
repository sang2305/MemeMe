//
//  MemeCollectionViewController.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/23/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController : UIViewController, UICollectionViewDataSource{
    
    var memescoll: [Meme]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memescoll = appDelegate.memes
       
    }
    
    
    @IBAction func addMeme(sender: AnyObject) {
        self.performSegueWithIdentifier("newMeme", sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memescoll.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let memesrow = self.memescoll[indexPath.item]
        
        cell.memeView.image = memesrow.memedImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailControllers = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailControllers.meme = self.memescoll[indexPath.row]
        self.navigationController!.pushViewController(detailControllers, animated: true)
        
    }

    
}
