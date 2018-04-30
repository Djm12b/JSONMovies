//
//  DetailViewController.swift
//  JSON
//
//  Created by Dakota Mathews on 4/10/18.
//  Copyright © 2018 Dakota Mathews. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var studioNetworkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var summaryView: UITextView!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            
            if let label = nameLabel {
                label.text = detail.name
            }
            
            if let label = formatLabel {
                label.text = detail.format
            }
            
            if let label = yearLabel {
                label.text = detail.yearStart
            }
            
            if let label = episodesLabel {
                label.text = String(describing:detail.episodesCount)
            }
            
            if let label = studioNetworkLabel {
                if let network = detail.network {
                    label.text = network
                }
                else if let studio = detail.studio {
                    label.text = studio
                }
                
            }
            
            if let imageView = imageView {
                
                let url = URL(string: detail.imageURL)
                let data = try? Data(contentsOf: url!)
                imageView.image = UIImage(data: data!)
            }
            
            if let label = descriptionLabel {
                label.text = detail.showDescription
            }
            
            if let label = summaryView {
                label.text = detail.showSummary
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
    
    var detailItem: DataObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
}
