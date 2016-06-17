//
//  MainDeparturesViewModel.swift
//  WatchDVB
//
//  Created by Max Kattner on 17.06.16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import DVB


//TODO Remove Protocol Implementations after upgrading to version of DVB-Framework that implements them
extension Stop: Equatable, Hashable {
	public var hashValue: Int {
		get {
			return name.hashValue + region.hashValue
		}
	}
}

public func ==(lhs: Stop, rhs: Stop) -> Bool {
	return lhs.hashValue == rhs.hashValue
}


final class MainDeparturesViewModel {
	
	private let stopsModel: StopsModel
	private var stopsWithDepartureModels: [Stop: DeparturesModel]
	
	init() {
		stopsModel = StopsModel()
		stopsWithDepartureModels = [:]
		
		for stop in stopsModel.stopsToDisplay {
			stopsWithDepartureModels[stop] = DeparturesModel(stop: stop, onUpdate: {
				[weak self] _ in
				self?.departuresDidUpdate(stop)
			})
		}
	}
	
	private func departuresDidUpdate(stop: Stop) {
		// propagate update to view
	}
	
}
