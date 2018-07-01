//
//  LoadingView.swift
//  PSFootball
//
//  Created by Lorenzo on 26/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

let Loading = LoadingView.getInstance

class LoadingView: UIView {
    
    @IBOutlet weak var indicatorView: UIView!
    
    static let getInstance = LoadingView.getView()
    var activityData: ActivityData?
    
    class func getView() -> LoadingView? {
        if
            let window = (UIApplication.shared.delegate?.window) as? UIWindow,
            let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?.first as? LoadingView {
            
            loadingView.activityData = ActivityData(size: loadingView.indicatorView.frame.size, type: NVActivityIndicatorType.ballTrianglePath, color: UIColor.bluePalette(level: .medium))
            
            window.addSubview(loadingView)
            
            return loadingView
        }
        return nil
    }
    
    func show() {
        if let activityData = self.activityData {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }
    
    func stop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        self.removeFromSuperview()
    }
}
