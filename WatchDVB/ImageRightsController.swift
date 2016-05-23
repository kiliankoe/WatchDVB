//
//  ImageRightsController.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class ImageRightsController: UITableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let url = NSURL(string: "https://thenounproject.com/search/?q=settings&i=337734")!
            UIApplication.sharedApplication().openURL(url)
        case 1:
            let url = NSURL(string: "https://thenounproject.com/search/?q=bus&i=7190")!
            UIApplication.sharedApplication().openURL(url)
        default:
            break
        }
    }

}
