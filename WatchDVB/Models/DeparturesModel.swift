//
//  DeparturesModel.swift
//  WatchDVB
//
//  Created by Max Kattner on 17.06.16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import DVB

final class DeparturesModel {
	
	private let stop: Stop
	
	private(set) var departures: [Departure]?
	
	private var onUpdate: (([Departure]) -> Void)?
	
	init(stop: Stop, onUpdate: (([Departure]) -> Void)? = nil) {
		self.onUpdate = onUpdate
		self.stop = stop
		DVB.monitor(stop.name) {
			[weak self] (departures) in
			self?.departures = departures
			self?.didLoadDepartures()
		}
	}
	
	private func didLoadDepartures() {
		guard let departures = self.departures else { return }
		self.onUpdate?(departures)
	}
	
}