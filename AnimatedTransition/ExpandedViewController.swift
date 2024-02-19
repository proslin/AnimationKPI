//
//  ExpandedViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

class ExpandedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    

    @objc func handleTap() {
        self.dismiss(animated: true, completion: nil)
    }
}
