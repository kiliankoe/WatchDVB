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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Stop.allSaved().count + 1 // Add cell for adding new stops
        default:
            return 2
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Haltestellen"
        default:
            return "Einstellungen"
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell()

        // Normalize reused cells
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = nil
        cell.accessoryType = .None

        switch indexPath.section {
        case 0:
            if indexPath.row >= Stop.allSaved().count {
                // This is the "Add new Stop" cell
                cell.textLabel?.text = "Neue Haltestelle hinzufügen..."
                cell.accessoryType = .DisclosureIndicator
            } else {
                // This is a normal stop cell
                cell.textLabel?.text = Stop.allSaved()[indexPath.row].description
                cell.accessoryType = Stop.selectedIndex() == indexPath.row ? .Checkmark : .None
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Autom. Nächstgelegene auswählen"
            case 1:
                cell.textLabel?.text = "Bildrechte"
                cell.accessoryType = .DisclosureIndicator
            default:
                break
            }
        default:
            break
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        switch indexPath.section {
        case 0:
            break
        case 1:
            switch indexPath.row {
            case 0:
                break
            case 1:
                performSegueWithIdentifier("showImageRights", sender: self)
            default:
                break
            }
        default:
            break
        }

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
