//
//  WatchSessionManager.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import WatchConnectivity
import DVB

class WatchSessionManager: NSObject, WCSessionDelegate {
    static let shared = WatchSessionManager()

    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil

    private var validSession: WCSession? {
        if let session = session where session.paired && session.watchAppInstalled {
            return session
        }
        return nil
    }

    func startSession() {
        session?.delegate = self
        session?.activateSession()
    }

    func session(session: WCSession, didReceiveMessage message: [String: AnyObject], replyHandler: ([String: AnyObject]) -> Void) {
        guard let message = message as? [String: String] else { return }
        guard let request = message["request"] else { return }

        switch request {
        case "selectedStop":
            replyHandler(["selectedStop": Stop.selected().toDict()])
        default:
            print("couldn't process message request")
        }
    }
}
