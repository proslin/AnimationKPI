//
//  AnimatedTransitionViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

class AnimatedTransitionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {
    var colorArray: Array<UIColor> = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .red, .orange, .yellow, .red, .orange, .yellow]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var openingFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    static func storyboardInstance() -> AnimatedTransitionViewController? {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "AnimatedTransitionID") as? AnimatedTransitionViewController
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colorArray[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // set frame of cell
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        let attributesFrame = attributes?.frame
        openingFrame = attributesFrame
        
        // present viewController
        let expandedVC = ExpandedViewController()
        expandedVC.transitioningDelegate  = self
//        expandedVC.modalPresentationStyle = .fullScreen
        expandedVC.modalPresentationStyle = .custom
        expandedVC.view.backgroundColor = colorArray[indexPath.row]
        present(expandedVC, animated: true)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let openingFrame = openingFrame else { return nil}
        return PresentAnimationController(originFrame: openingFrame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let _ = dismissed as? ExpandedViewController, let openingFrame = openingFrame else {
          return nil
        }
        return DismissAnimationController(destinationFrame: openingFrame)
    }
    
}
