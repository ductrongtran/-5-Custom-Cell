//
//  AppleProductsTableViewController.swift
//  Pretty Apple
//
//  Created by Duc Tran on 3/28/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class AppleProductsTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem()
    }

    // MARK: - Data Source
    
    lazy var productLines: [ProductLine] = {
        return ProductLine.productLines()
    }()
 
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let productLine = productLines[section]
        return productLine.name
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return productLines.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productLine = productLines[section]
        return productLine.products.count   // the number of products in the section
    }

    // indexPath: which section and which row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Product Cell", forIndexPath: indexPath) as UITableViewCell

        let productLine = productLines[indexPath.section]
        let product = productLine.products[indexPath.row]
        cell.textLabel?.text = product.title
        cell.detailTextLabel?.text = product.description
        cell.imageView?.image = product.image
        
        return cell
    }
    
    // MARK: - Edit Tableview
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let productLine = productLines[indexPath.section]
            productLine.products.removeAtIndex(indexPath.row)
            // tell the table view to update with new data source
//            tableView.reloadData()    Bad way!
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
}







































