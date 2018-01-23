//
//  ViewController.swift
//  d06
//
//  Created by Aymeric TOULOUSE on 1/16/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var gravity = UIGravityBehavior()
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var dynamicItem: UIDynamicItemBehavior!
    
    var forms : [Form] = []
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        for form in forms {
            form.view.removeFromSuperview()
            collision.removeItem(form.view)
        }
        forms = []
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        print("taped", sender.location(in: view))
        
        let pos = sender.location(in: view)
        let form = Form(x: Double(pos.x), y: Double(pos.y), size: 100)

        let moove = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        let resize = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(_:)))
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotationGesture(_:)))

        form.view.addGestureRecognizer(moove)
        form.view.addGestureRecognizer(resize)
        form.view.addGestureRecognizer(rotate)
        
        view.addSubview(form.view)
        gravity.addItem(form.view)
        dynamicItem.addItem(form.view)
        collision.addItem(form.view)
        
        forms.append(form)
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        if let view = sender.view {
            switch sender.state {
            case .began:
                print("moove began")
                gravity.removeItem(view)
            case .changed:
                print("moove changed", sender.location(in: self.view))
                view.center = sender.location(in: self.view)
                animator.updateItem(usingCurrentState: view)
            case .failed, .cancelled:
                print("moove failed or cancelled")
            case .possible:
                print("moove possible")
            case .ended:
                print("moove ended")
                gravity.addItem(view)
            }
        }
    }
    
    @objc func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            switch sender.state {
            case .began:
                print("resize began")
                gravity.removeItem(view)
                dynamicItem.removeItem(view)
            case .changed:
                print("resize changed")
                collision.removeItem(view)
                view.layer.bounds.size.height *= sender.scale
                view.layer.bounds.size.width *= sender.scale
                if view.layer.cornerRadius != 0 {
                    view.layer.cornerRadius *= sender.scale
                }
                sender.scale = 1.0
                collision.addItem(view)
            case .failed, .cancelled:
                print("resize failed or cancelled")
            case .possible:
                print("resize possible")
            case .ended:
                print("resize ended")
                gravity.addItem(view)
                dynamicItem.addItem(view)
            }
        }
    }
    
    @objc func rotationGesture(_ sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            switch sender.state {
            case .began:
                print("rotation began")
                gravity.removeItem(view)
                collision.removeItem(view)
                dynamicItem.removeItem(view)
            case .changed:
                print("rotation changed")
                view.transform = view.transform.rotated(by: sender.rotation)
                animator.updateItem(usingCurrentState: view)
                sender.rotation = 0
            case .failed, .cancelled:
                print("rotation failed or cancelled")
            case .possible:
                print("rotation possible")
            case .ended:
                print("rotation ended")
                gravity.addItem(view)
                collision.addItem(view)
                dynamicItem.addItem(view)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dynamicItem = UIDynamicItemBehavior()
        dynamicItem.elasticity = 0.5
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        animator = UIDynamicAnimator(referenceView: view)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(dynamicItem)

        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        collision.addItem(barrier)
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))

    }
}

