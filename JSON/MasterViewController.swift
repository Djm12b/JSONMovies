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

// the json Url
    let URL_IMDB = "https://api.myjson.com/bins/1ahrbf"
    
    var nameArray = [String]()
    var objects = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image:#imageLiteral(resourceName: "irdblogo.png"))
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        // Do any additional setup after loading the view, typically from a nib.
        // navigationItem.leftBarButtonItem = editButtonItem
        
                  getJsonFromUrl();

//       let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
       //navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this function is fetching the json from URL
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: URL_IMDB)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url! as URL), completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj!.value(forKey: "franchise")!)
                self.nameArray = jsonObj!.value(forKey: "franchise") as! [Any] as! [String]
                
                //getting the avengers tag array from json and converting it to NSArray
                if let MoviesArray = jsonObj!.value(forKey: "franchiseName") as? NSArray {
                    //looping through all the elements
                    for Movies in MoviesArray{

                        //converting the element to a dictionary
                        if let MoviesDict = Movies as? NSDictionary {

                            //getting the name from the dictionary
                            if let name = MoviesDict.value(forKey: "name") {

                                //adding the name to the array
                                self.nameArray.append((name as? String)!)
                            }

                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    //self.showNames()
                })
            }
        }).resume()
    }
//    @objc
//    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! String
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! String
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

