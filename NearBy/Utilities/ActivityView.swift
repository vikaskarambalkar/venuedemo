//
//  ActivityView.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import UIKit


class ActivityView: UIView {


    @IBOutlet weak var titleLabel: UILabel!
    private static var activityView: ActivityView!
    static func showActivityIndicator(label: String) {
        if activityView == nil {
            activityView = UINib(nibName: "ActivityView",
                                 bundle: nil).instantiate(withOwner: nil,
                                                          options: nil)[0] as? ActivityView
            activityView.frame = UIScreen.main.bounds
        }
        activityView.titleLabel.text = label
        keyWindow?.addSubview(activityView)
    }
    
    static func hideActivityIndicator() {
        DispatchQueue.main.async {
            activityView.removeFromSuperview()
        }

    }
}
