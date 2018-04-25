//
//  MasterViewController.swift
//  JSON
//
//  Created by Dakota Mathews on 4/10/18.
//  Copyright © 2018 Dakota Mathews. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    struct Movie: Decodable{
        let franchiseName: String
        let name: String
        
        //OLD
//        init(json: [String: Any]) {
//            franchiseName = json["franchiseName"] as? String ?? ""
//            name = json["name"] as? String ?? ""
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image:#imageLiteral(resourceName: "irdblogo.png"))
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        // Do any additional setup after loading the view, typically from a nib.
        // navigationItem.leftBarButtonItem = editButtonItem
    
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        }
        let jsonUrlString = "https://api.myjson.com/bins/1ahrbf"
        guard let url = URL(string: jsonUrlString)
            else {return}
        
        URLSession.shared.dataTask(with: url) {( data, responds, err) in
        //perhaps check err
        //also perhaps check response status 200 OK
        
        guard let data = data else { return }
        
//        let dataAsString = String(data: data, encoding: .utf8)
//    print(dataAsString)
        
            do{
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                    print(movies)
                //swift 2/3/odjC OLD!!!
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
//
//
//                let course = Course(json: json)
//                print(course.name)
           }
            catch let jsonErr {
                print("Error Serializing JSON:", jsonErr )
            }
            
            
            }.resume()
    }
}
