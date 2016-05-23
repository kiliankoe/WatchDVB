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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = getSelectedStop().name
        refreshDVB()
    }

    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
        refreshDVB()
    }

    func getSelectedStop() -> Stop {
        let selectedStopIndex = NSUserDefaults.standardUserDefaults().integerForKey(Defaults.selectedStopIndex)
        let savedStops = NSUserDefaults.standardUserDefaults().arrayForKey(Defaults.savedStops) as! [NSDictionary]
        return Stop.fromDict(savedStops[selectedStopIndex])
    }

    func refreshDVB() {
        let selectedStop = getSelectedStop()

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
