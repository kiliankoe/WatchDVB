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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = Stop.selected().name
        refreshDVB()
    }

    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        refreshDVB()
    }

    func refreshDVB() {
        let selectedStop = Stop.selected()

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DVB.monitor(selectedStop.name, city: selectedStop.region) { (departures) in
            OperationQueue.mainQueue().addOperationWithBlock({
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDepartures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departureCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "departureCell")

        let dep = currentDepartures[indexPath.row]
        let title = "\(dep.line) \(dep.direction)"
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = dep.minutesUntil == 0 ? "jetzt" : "in \(dep.minutesUntil) min."

        return cell
    }
}

// MARK: - Table View Delegate
extension MainOverviewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        let departure = currentDepartures[indexPath.row]
        let notificationOffset = 10 // minutes

        // No need scheduling a notification if the departure is about to leave
        guard departure.minutesUntil > notificationOffset else { return }

        let notification = UILocalNotification()
        notification.fireDate = departure.leavingDate.dateByAddingTimeInterval(-1 * Double(notificationOffset) * 60)

        var text = ""
        switch departure.type {
        case .Some(.Stadtbus):
            text += "Dein Bus "
        case .Some(.Strassenbahn):
            text += "Deine Bahn "
        default:
            text += "Deine Verbindung "
        }
        text += "fährt in \(notificationOffset) Minuten von der Haltestelle \(Stop.selected().name)"

        notification.alertBody = text
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.cancelAllLocalNotifications()
        UIApplication.shared.scheduleLocalNotification(notification)
        print("Scheduled local notification \(notification)")
    }
}
