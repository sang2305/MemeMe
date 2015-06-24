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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fullMemeView.image = meme.memedImage
    }
    
    
}


