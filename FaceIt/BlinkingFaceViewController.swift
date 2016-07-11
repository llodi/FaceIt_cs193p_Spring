//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by Ilya Dolgopolov on 11/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {
    var blinking = false {
        didSet {
            startBlinking()
        }
    }
    
    private struct BlinkRate {
        static let CloseDuration = 0.1
        static let OpenDuration = 0.5
    }
    
    func startBlinking() {
        if blinking {
            faceView.eyeOpen = false
            NSTimer.scheduledTimerWithTimeInterval(
                BlinkRate.CloseDuration,
                target: self,
                selector: #selector(BlinkingFaceViewController.endBlink),
                userInfo: nil,
                repeats: false
            )
        }
    }
    
    func endBlink() {
        faceView.eyeOpen = true
        NSTimer.scheduledTimerWithTimeInterval(
            BlinkRate.OpenDuration,
            target: self,
            selector: #selector(BlinkingFaceViewController.startBlinking),
            userInfo: nil,
            repeats: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
    
}
