//
//  SettingsController.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import UIKit
import DVB

class SettingsController: UITableViewController {

    var savedStops: [Stop]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Get saved stops from NSUserDefaults and store in savedStops
        let helmholtz = Stop(id: 0, name: "Helmholtzstraße", region: "Dresden", searchString: "", tarifZones: "", longitude: 1.0, latitude: 1.0, priority: 0)
        savedStops = [helmholtz]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier(String(StopSelectionCell)) ?? StopSelectionCell()
            cell.textLabel?.text = savedStops[indexPath.row].description
        } else if indexPath.section == 1 {
            cell = UITableViewCell()
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Autom. Nächstgelegene auswählen"
                cell.imageView?.image = UIImage(named: "checkmark")!
            case 1:
                cell.textLabel?.text = "Bildrechte"
            default:
                break
            }
        } else {
            cell = UITableViewCell()
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
