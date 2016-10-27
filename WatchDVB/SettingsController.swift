//
//  SettingsController.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import UIKit
import DVB
import MessageUI

class SettingsController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Making sure that just added stops are being displayed
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Stop.allSaved().count + 1 // Add cell for adding new stops
        default:
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Haltestellen"
        default:
            return "Einstellungen"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()

        // Normalize reused cells
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = nil
        cell.accessoryType = .none

        switch (indexPath as NSIndexPath).section {
        case 0:
            if indexPath.row >= Stop.allSaved().count {
                // This is the "Add new Stop" cell
                cell.textLabel?.text = "Neue Haltestelle hinzufügen..."
                cell.accessoryType = .disclosureIndicator
            } else {
                // This is a normal stop cell
                cell.textLabel?.text = Stop.allSaved()[indexPath.row].description
                cell.accessoryType = Stop.selectedIndex() == indexPath.row ? .Checkmark : .None
            }
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.textLabel?.text = "Autom. Nächstgelegene auswählen"
            case 1:
                cell.textLabel?.text = "Bildrechte"
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = "Feedback"
                cell.accessoryType = .disclosureIndicator
            default:
                break
            }
        default:
            break
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch (indexPath as NSIndexPath).section {
        case 0:
            if indexPath.row >= Stop.allSaved().count {
                // This is the "Add new Stop" cell
                performSegue(withIdentifier: "showAddNewStop", sender: self)
            } else {
                // This is a normal stop cell
                Stop.setSelected(indexPath.row)
                tableView.reloadData()
            }
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                break
            case 1:
                performSegue(withIdentifier: "showImageRights", sender: self)
            case 2:
                if MFMailComposeViewController.canSendMail() {
                    let emailVC = MFMailComposeViewController()
                    emailVC.mailComposeDelegate = self
                    emailVC.setSubject("WatchDVB Feedback")
                    emailVC.setToRecipients(["watchdvb@kilian.io"])
                    present(emailVC, animated: true, completion: nil)
                }
            default:
                break
            }
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row < Stop.allSaved().count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Stop.removeAtIndex(indexPath.row)
            // FIXME: This currently leads to a crash if the currently selected stop is removed
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension SettingsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
