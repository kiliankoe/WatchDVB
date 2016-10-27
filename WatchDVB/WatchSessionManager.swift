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

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {
        
    }

    fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil

    fileprivate var validSession: WCSession? {
        if let session = session , session.isPaired && session.isWatchAppInstalled {
            return session
        }
        return nil
    }

    func startSession() {
        session?.delegate = self
        session?.activate()
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
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
