//
//  Meme.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/22/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation
import UIKit

struct Meme{
    var toptext : String
    var bottomtext : String
    var image : UIImage
    var memedImage : UIImage!
    
    init(toptext : String! , bottomtext : String! , image : UIImage! , memedImage : UIImage! ){
        
        self.toptext = toptext
        self.bottomtext = bottomtext
        self.image = image
        self.memedImage = memedImage
    }

}


