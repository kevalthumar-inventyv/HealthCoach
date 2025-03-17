//
//  SideMenuViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 12/03/25.
//

import UIKit

class SideMenuManager {
    
    static let shared = SideMenuManager()
    
    private var overlayView: UIView!
    private var sideMenuView: UIView?
    
    private init() {
        
    }
    
    
    func showSideMenu(in viewController: UIViewController, sideMenuView: UIView) {
        self.sideMenuView = sideMenuView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sideMenuView.frame.origin.x = -sideMenuView.frame.width
        }
        
        if overlayView == nil {
            overlayView = UIView(frame: viewController.view.bounds)
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            overlayView.alpha = 0
            overlayView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideMenu))
            overlayView.addGestureRecognizer(tapGesture)
        }
        
        viewController.view.addSubview(overlayView)
        viewController.view.addSubview(sideMenuView)
        viewController.view.bringSubviewToFront(sideMenuView)
        
        setupGestures(for: viewController.view)
    }

    private func setupGestures(for view: UIView) {
        let swipeGestureClose = UISwipeGestureRecognizer(target: self, action: #selector(closeSideMenu))
        swipeGestureClose.direction = .left
        view.addGestureRecognizer(swipeGestureClose)

        let swipeGestureOpen = UISwipeGestureRecognizer(target: self, action: #selector(openSideMenu))
        
        swipeGestureOpen.direction = .right
        view.addGestureRecognizer(swipeGestureOpen)
    }
    
    @objc func openSideMenu() {
        guard let sideMenuView = sideMenuView else { return }
        sideMenuView.alpha = 1
        UIView.animate(withDuration: 0.3) {
            sideMenuView.frame.origin.x = 0
            self.overlayView.alpha = 0.5
        }
    }

    @objc func closeSideMenu() {
        guard let sideMenuView = sideMenuView else { return }
        
        UIView.animate(withDuration: 0.3) {
            sideMenuView.frame.origin.x = -sideMenuView.frame.width
            self.overlayView.alpha = 0
        }
    }
}

