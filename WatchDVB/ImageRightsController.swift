//
//  ImageRightsController.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class ImageRightsController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            let url = URL(string: "https://thenounproject.com/search/?q=settings&i=337734")!
            UIApplication.shared.openURL(url)
        case 1:
            let url = URL(string: "https://thenounproject.com/search/?q=bus&i=7190")!
            UIApplication.shared.openURL(url)
        default:
            break
        }
    }

}
