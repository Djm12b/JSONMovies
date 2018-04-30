//
//  DataObject.swift
//  JSON
//
//  Created by Dakota Mathews on 4/30/18.
//  Copyright © 2018 Dakota Mathews. All rights reserved.
//

import UIKit

class DataObject: NSObject {
    
    var name = String()
    var format = String()
    var yearStart = String()
    var yearEnd: String?
    var episodesCount: Int!
    var network: String?
    var studio: String?
    var imageURL = String()
    var showDescription = String()
    var showSummary = String()
    var castArray = [Dictionary<String, String>]()
    
    
    convenience init(withObject dictionary: Dictionary<String,AnyObject>) {
        self.init()
        
        name = dictionary["name"] as! String
        format = dictionary["format"] as! String
        yearStart = dictionary["yearStart"] as! String
        if let val = dictionary["yearEnd"] {
            //now val is not nil and the Optional has been unwrapped so use it
            yearEnd = val as? String
        }
        if let val = dictionary["episodes"] {
            //now val is not nil and the Optional has been unwrapped so use it
            episodesCount = val as? Int
        }
        if let val = dictionary["network"] {
            //now val is not nil and the Optional has been unwrapped so use it
            network = val as? String
        }
        if let val = dictionary["studio"] {
            //now val is not nil and the Optional has been unwrapped so use it
            studio = val as? String
        }
        imageURL = dictionary["imageURL"] as! String
        showDescription = dictionary["description"] as! String
        showSummary = dictionary["summary"] as! String
        castArray = dictionary["starring"] as! [Dictionary<String,String>]
    }
    
}
