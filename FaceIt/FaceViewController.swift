//
//  ViewController.swift
//  FaceIt
//
//  Created by Ilya Dolgopolov on 29.05.16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(_:))
             ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    
    
    @IBAction func turnEyeBrows(recognizer: UIRotationGestureRecognizer) {
        if recognizer.rotation > 0 {
            expression.eyeBrows = expression.eyeBrows.moreRelaxedBrow()
        } else {
            expression.eyeBrows = expression.eyeBrows.moreFurrowedBrow()
        }
    }
    
    func increaseHappiness () {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness () {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin:  0.5 , .Smile: 1.0, .Smirk: -0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Furrowed: -0.5, .Relaxed: 0.5, .Normal: 0.0]
    
    private func updateUI () {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyeOpen = true
            case .Closed: faceView.eyeOpen = false
            case .Squinting: faceView.eyeOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
            
        
    }
    
}

