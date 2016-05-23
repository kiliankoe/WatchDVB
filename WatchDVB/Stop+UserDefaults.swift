//
//  Stop+UserDefaults.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import DVB

// Hello random stranger, thanks for finding this.
// Before you look on though, I want to warn you that this is _really_ shitty code.
// You're welcome to fix it, but if you don't feel like it, just like I did when writing this comment,
// please just look at something else, thanks :D

extension Stop {
    func toDict() -> NSDictionary {
        var dict = [String: String]()
        dict["name"] = self.name
        dict["region"] = self.region
        dict["searchString"] = self.searchString
        dict["tarifZones"] = self.tarifZones
        dict["longitude"] = String(self.location.longitude)
        dict["latitude"] = String(self.location.latitude)
        return dict as NSDictionary
    }

    static func fromDict(dict: NSDictionary) -> Stop {
        let name = dict["name"]! as! String
        let region = dict["region"]! as! String
        let searchString = dict["searchString"]! as! String
        let tarifZones = dict["tarifZones"]! as! String
        let lon = Double(dict["longitude"]! as! String)!
        let lat = Double(dict["latitude"]! as! String)!

        return Stop(id: 0, name: name, region: region, searchString: searchString, tarifZones: tarifZones, longitude: lon, latitude: lat, priority: 0)
    }

    static func allSaved() -> [Stop] {
        let savedStops = NSUserDefaults.standardUserDefaults().arrayForKey(Defaults.savedStops) as! [NSDictionary]
        return savedStops.map {
            Stop.fromDict($0)
        }
    }

    static func saveByOverwriting(all: [Stop]) {
        let dicts = all.map { $0.toDict() }
        NSUserDefaults.standardUserDefaults().setObject(dicts, forKey: Defaults.savedStops)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    static func forIndex(idx: Int) -> Stop {
        return allSaved()[idx]
    }

    static func add(stop: Stop, atIndex idx: Int? = nil) {
        var all = allSaved()
        if let idx = idx {
            all.insert(stop, atIndex: idx)
        } else {
            all.append(stop)
        }
        saveByOverwriting(all)
    }

    static func removeAtIndex(idx: Int) {
        var all = allSaved()
        all.removeAtIndex(idx)
        saveByOverwriting(all)
    }

    static func selectedIndex() -> Int {
        let all = allSaved()
        let selectedStopName = NSUserDefaults.standardUserDefaults().stringForKey(Defaults.selectedStopName)
        return all.indexOf { $0.name == selectedStopName } ?? -1
    }

    static func selected() -> Stop {
        let selectedStopIndex = selectedIndex()
        return allSaved()[selectedStopIndex]
    }

    static func setSelected(stop: Stop) {
        NSUserDefaults.standardUserDefaults().setObject(stop.name, forKey: Defaults.selectedStopName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
