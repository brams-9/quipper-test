//
//  HomeScreenWireFrame.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation
import UIKit

class HomeScreenWiframe {
    private var homeScreenViewController: UIViewController
    init() {
        homeScreenViewController = HomeScreenViewController()
    }
    
    func getViewController() -> UIViewController {
        return homeScreenViewController
    }
}
