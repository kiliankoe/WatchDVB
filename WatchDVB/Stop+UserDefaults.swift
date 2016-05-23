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

    static func selectedIndex() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey(Defaults.selectedStopIndex)
    }

    static func selected() -> Stop {
        let selectedStopIndex = selectedIndex()
        return allSaved()[selectedStopIndex]
    }
}
