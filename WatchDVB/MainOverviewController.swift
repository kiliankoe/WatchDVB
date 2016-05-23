//
//  MainOverviewController.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import UIKit
import DVB

class MainOverviewController: UITableViewController {

    var currentDepartures = [Departure]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = Stop.selected().name
        refreshDVB()
    }

    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
        refreshDVB()
    }

    func refreshDVB() {
        let selectedStop = Stop.selected()

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        DVB.monitor(selectedStop.name, city: selectedStop.region) { (departures) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                [weak self] in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self?.currentDepartures = departures
                self?.tableView.reloadData()
            })
        }
    }
}

// MARK: - Table View Data Source
extension MainOverviewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDepartures.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("departureCell") ?? UITableViewCell(style: .Value1, reuseIdentifier: "departureCell")

        let dep = currentDepartures[indexPath.row]
        let title = "\(dep.line) \(dep.direction)"
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = dep.minutesUntil == 0 ? "jetzt" : "in \(dep.minutesUntil) min."

        return cell
    }
}

// MARK: - Table View Delegate
extension MainOverviewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        defer {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }

        let departure = currentDepartures[indexPath.row]

        // No need scheduling a notification if the departure is about to leave
        guard departure.minutesUntil > 5 else { return }

        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: Double(departure.minutesUntil) * 60)

        var text = ""
        switch departure.type {
        case .Some(.Stadtbus):
            text += "Dein Bus "
        case .Some(.Strassenbahn):
            text += "Deine Bahn "
        default:
            text += "Deine Verbindung "
        }
        text += "fährt in 5 Minuten von der Haltestelle \(Stop.selected().name)"

        notification.alertBody = text
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
