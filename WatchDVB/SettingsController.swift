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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        // Making sure that just added stops are being displayed
        tableView.reloadData()
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
            if indexPath.row >= Stop.allSaved().count {
                // This is the "Add new Stop" cell
                performSegueWithIdentifier("showAddNewStop", sender: self)
            } else {
                // This is a normal stop cell
            }
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

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row < Stop.allSaved().count
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            Stop.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
