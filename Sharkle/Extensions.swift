//
//  AnimatedView.swift
//  Sharkle
//
//  Created by Peter Wunder on 21.04.17.
//  Copyright © 2017 Peter Wunder. All rights reserved.
//

import Cocoa

extension NSView {
    
    // This makes an NSView loop through an Array of NSImages for x seconds and y times and optionally executes a completion block afterwards
    func animate(withImages images: [NSImage], andDuration duration: Double, repeatTimes repeats: Float = Float.infinity, afterWhich completion: (()->Void)? = {}) {
        if let completionClosure = completion {
            // TIL: Using a Timer is more precise than using Dispatch.asyncAfter
            Timer.schedule(delay: duration * Double(repeats), handler: { timer in
                completionClosure()
            })
        }
        
        self.layer = CALayer()
        self.wantsLayer = true
        
        let animLayer = CALayer()
        let keyPath = "contents"
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.calculationMode = kCAAnimationDiscrete
        
        animation.duration = duration
        animation.repeatCount = repeats
        
        animation.values = images
        
        let layerRect = CGRect(origin: .zero, size: self.frame.size)
        animLayer.frame = layerRect
        
        animLayer.add(animation, forKey: keyPath)
        
        self.layer?.addSublayer(animLayer)
    }
    
    // Cheap way of making a previously set animation stop
    func stopAnimating() {
        self.layer = CALayer()
    }
    
}

extension Array {
    
    // Picks a random element from an Array
    func random() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}

extension Timer {
    class func schedule(delay: TimeInterval, handler: @escaping (Timer!) -> Void) {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
    }
}
