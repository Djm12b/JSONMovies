//
//  DataController.swift
//  JSON
//
//  Created by Dakota Mathews on 4/30/18.
//  Copyright © 2018 Dakota Mathews. All rights reserved.
//

import UIKit

class DataController: NSObject {
    
    let MY_URL = "https://api.myjson.com/bins/1ahrbf"
    var franchises = [String]()
    var objectsReturned = [DataObject]()
    var fullData = [[DataObject]]()
    
    //this function is fetching the json from URL
    func getJsonFromUrl() {
        //creating a NSURL
        let url = NSURL(string: MY_URL)
        
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as?NSDictionary {
                
                if let allThatData = jsonObj!.value(forKey: "datData") as? NSDictionary {
                    
                    if let franchiseArray = allThatData.value(forKey: "franchise") as? NSArray {
                        
                        //looping through all the elements
                        for franchiseDict in franchiseArray {
                            if let franchiseName = (franchiseDict as!                           NSDictionary).value(forKey: "franchiseName") as? String {
                                //adding the name to the array
                                self.franchises.append(franchiseName)
                                
                                //now get all the data out for each element in the section
                                //array of arrays will be easier to manage, methinks...
                                if let entriesArray = (franchiseDict as! NSDictionary).value(forKey: "entries") as? NSArray {
                                    //reset the array?
                                    self.objectsReturned = []
                                    for entryObject in entriesArray{
                                        
                                        //pass the dictionary over and convert it to an object
                                        let thisEntry = DataObject(withObject: entryObject as! Dictionary<String, AnyObject>)
                                        
                                        print(thisEntry.name)
                                        self.objectsReturned.append(thisEntry)
                                    }
                                }
                            }
                            self.fullData.append(self.objectsReturned)
                        }
                    }
                    print(self.fullData)
                }
            }
        }).resume()
    }
}
