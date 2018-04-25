//
//  DetailViewController.swift
//  JSON
//
//  Created by Dakota Mathews on 4/10/18.
//  Copyright © 2018 Dakota Mathews. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    //var objects = [Any]()
    
    //let URL_IMDB = "https://api.myjson.com/bins/1ahrbf"

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String? {
        didSet {
            navigationItem.title = "IMDB"
            let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.red]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            // Update the view.
            configureView()
        }
    }
//    func getJsonFromUrl(){
//        //creating a NSURL
//        let url = NSURL(string: URL_IMDB)
//
//        //fetching the data from the url
//        URLSession.shared.dataTask(with: (url! as URL), completionHandler: {(data, response, error) -> Void in
//
//            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
//
//                //printing the json in console
//                print(jsonObj!.value(forKey: "name")!)
//                self.objects = jsonObj!.value(forKey: "name") as! [Any]
//            }
//        }
//)
//}

}
