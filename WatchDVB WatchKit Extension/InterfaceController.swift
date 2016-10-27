//
//  InterfaceController.swift
//  WatchDVB WatchKit Extension
//
//  Created by Kilian Költzsch on 22/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session: WCSession?

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    @IBOutlet var table: WKInterfaceTable!

    var deps = ["85 Löbtau", "85 Btf. Gruna", "85 Striesen"]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupTable()

    }

    func setupTable() {
        table.setNumberOfRows(3, withRowType: "departureRow")
        for (idx, dep) in deps.enumerated() {
            if let row = table.rowController(at: idx) as? DepartureRow {
                row.textLabel.setText(dep)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        session = WCSession.default()
        session?.delegate = self
        session?.activate()

        session?.sendMessage(["request": "selectedStop"],
            replyHandler: { response in
                print(response)
            }, errorHandler: { err in
                print(err)
            }
        )
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }

}
