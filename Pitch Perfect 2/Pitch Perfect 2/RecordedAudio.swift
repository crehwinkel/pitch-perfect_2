//
//  RecordedAudio.swift
//  Pitch Perfect 2
//
//  Created by Christine Rehwinkel on 3/9/15.
//  Copyright (c) 2015 Christine Rehwinkel. All rights reserved.
//

import Foundation
import AVFoundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}