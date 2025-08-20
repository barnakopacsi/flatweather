//
//  UINavigationControllerExtension.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 26..
//
//  Enables swipe-to-go-back gesture in the app.
//

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {    
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
