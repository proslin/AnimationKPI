//
//  ViewTransitionViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 27.02.2024.
//

import UIKit

class ViewTransitionViewController: UIViewController {

    @IBOutlet weak var jockerView: UIImageView!
    @IBOutlet weak var aceView: UIImageView!
    var isFlipped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func storyboardInstance() -> ViewTransitionViewController? {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "ViewTransitionViewController") as? ViewTransitionViewController
        }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let vc = AnimatedTransitionViewController.storyboardInstance() else { return }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func flipOver(_ sender: UIButton) {
        // без опции .showHideTransitionViews вью с которой мы переходим будет удаляться
        isFlipped = !isFlipped
        let fromView = isFlipped ? aceView : jockerView
        let toView = isFlipped ? jockerView : aceView
        UIView.transition(from: fromView!, to: toView!, duration: 0.5, options: [.curveEaseOut, .transitionFlipFromLeft, .showHideTransitionViews])
    }

}
