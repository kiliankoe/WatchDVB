//
//  InterfaceController.swift
//  WatchDVB WatchKit Extension
//
//  Created by Kilian Költzsch on 22/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!

    var deps = ["85 Löbtau", "85 Btf. Gruna", "85 Striesen"]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setupTable()
    }

    func setupTable() {
        table.setNumberOfRows(3, withRowType: "departureRow")
        for (idx, dep) in deps.enumerate() {
            if let row = table.rowControllerAtIndex(idx) as? DepartureRow {
                row.textLabel.setText(dep)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        print(rowIndex)
    }

}
