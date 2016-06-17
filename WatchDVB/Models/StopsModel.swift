//
//  StopsModel.swift
//  WatchDVB
//
//  Created by Max Kattner on 17.06.16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import DVB

final class StopsModel {
	
	var stopsToDisplay: [Stop]
	
	init() {
		self.stopsToDisplay = DVB.find("Pirnaischer Platz")
	}
	
}
