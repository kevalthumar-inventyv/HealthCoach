//
//  Navigation.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//
import UIKit

class Navigation {
    static let shared = Navigation()

    private init() {}

    @discardableResult
    func navigate(
        animated: Bool = true,
        from rootViewController: UIViewController,
        withIdentifier identifier: String
    ) -> UIViewController {

        let nextVC: UIViewController =
            (rootViewController.storyboard?.instantiateViewController(
                withIdentifier: identifier))!

        rootViewController.navigationController?.pushViewController(
            nextVC, animated: animated)

        return nextVC

    }

    func popViewController(
        animated: Bool = true, from rootViewController: UIViewController
    ) {
        rootViewController.navigationController?.popViewController(
            animated: animated)
    }

    func popToRootViewController(
        animated: Bool = true, from rootViewController: UIViewController
    ) {
        rootViewController.navigationController?.popToRootViewController(
            animated: animated)
    }

    @discardableResult
    func makeConditionViewController(
        firstIdentifier:String,
        secondIdentifier:String,
        animated: Bool = true,
        from rootViewController: UIViewController,
        condition: Bool
    ) -> UIViewController {
        let identifier = condition ? firstIdentifier : secondIdentifier
        return navigate(animated: animated, from: rootViewController, withIdentifier: identifier)
    }

}
