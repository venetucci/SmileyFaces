//
//  CanvasViewController.swift
//  SmileyFace
//
//  Created by Michelle Harvey on 2/17/16.
//  Copyright © 2016 Michelle Venetucci Harvey. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var trayOriginalCenter: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        
          if sender.state == UIGestureRecognizerState.Began {
                trayOriginalCenter = trayView.center
          } else if sender.state == UIGestureRecognizerState.Changed {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    
          } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.y > 0 {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 5.0, initialSpringVelocity: 0.5, options: [ ], animations: { () -> Void in
                    self.trayView.center = self.trayDown
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 5.0, initialSpringVelocity: 0.5, options: [ ], animations: { () -> Void in
                    self.trayView.center = self.trayUp
                    }, completion: nil)
            }
    
        }
    }
    
    
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanNewFace:")
        var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinchNewFace:")
        
          if sender.state == UIGestureRecognizerState.Began {
            let imageView = sender.view as! UIImageView
            
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            self.newlyCreatedFace.userInteractionEnabled = true
            self.newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            self.newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [ ], animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(2.5, 2.5)
                }, completion: nil)
    
          } else if sender.state == UIGestureRecognizerState.Changed {
                newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    
          } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [ ], animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
//                self.originalScale = 1
                }) { (Bool) -> Void in
                    
                }
          }
        
    }
    
    func didPanNewFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
    
    }
    }
    
    func didPinchNewFace(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
          if sender.state == UIGestureRecognizerState.Began {
            newlyCreatedFace = sender.view as! UIImageView
        } else if sender.state == UIGestureRecognizerState.Changed {
            print(newlyCreatedFace.transform)
            newlyCreatedFace.transform = CGAffineTransformScale(newlyCreatedFace.transform, CGFloat(scale), CGFloat(scale))
            sender.scale = 1
        } else if sender.state == UIGestureRecognizerState.Ended {
//            originalScale = newlyCreatedFace.scale
        }

//        print("did pinch")
//        self.newlyCreatedFace.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
    
}
