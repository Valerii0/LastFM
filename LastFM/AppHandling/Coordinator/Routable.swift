//
//  Routable.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/21/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

protocol Routable {
    var navigationController: UINavigationController { get set }
    func push(controller: UIViewController, animated: Bool)
    func present(controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRootViewController(animated: Bool)
    func dismiss(animated: Bool)
}

enum RouterType {
    case mainRouter
}

extension RouterType {
    var router: Routable {
        switch self {
        case .mainRouter:
            return MainRouter()
        }
    }
}

extension Routable {
    func push(controller: UIViewController, animated: Bool = false) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func present(controller: UIViewController, animated: Bool = false) {
        navigationController.present(controller, animated: animated, completion: nil)
    }
    
    func pop(animated: Bool = false) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool = false) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = false) {
        navigationController.dismiss(animated: animated, completion: nil)
    }
}

class MainRouter: Routable {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}
