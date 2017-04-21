//
//  ViewController.swift
//  Sharkle
//
//  Created by Peter Wunder on 20.04.17.
//  Copyright © 2017 Peter Wunder. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    @IBOutlet weak var sharkleIdleView: NSView!
    @IBOutlet weak var sharkleWaveView: NSView!
    @IBOutlet weak var sharkleBubbleView: NSView!
    
    // Global AVAudioPlayer variable, gets set in mouseDown event
    var player: AVAudioPlayer!
    
    let idleImages: [NSImage] = (0..<8).map({ NSImage(named: "sharkle_idle\($0)")! })
    let idleAnimDuration = 0.666
    
    let waveImages: [NSImage] = (0..<4).map({ NSImage(named: "sharkle_wave\($0)")! })
    let waveAnimDuration = 0.4
    
    let bubbleImages: [NSImage] = (0..<2).map({ NSImage(named: "sharkle_bubble\($0)")! })
    let bubbleAnimDuration = 0.8
    
    let sharkleSounds: [URL] = (0..<8).map({ URL(fileURLWithPath: Bundle.main.path(forResource: "hey_\($0)", ofType: "m4a")!) })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharkleIdleView.animate(withImages: idleImages, andDuration: idleAnimDuration)
    }
    
    var animationIsPlaying = false
    override func mouseDown(with event: NSEvent) {
        if animationIsPlaying {
            // Sharkle is currently waving, don't interrupt him
            return
        }
        
        animationIsPlaying = true
        
        do {
            player = try AVAudioPlayer(contentsOf: sharkleSounds.random())
            player.volume = 2.0 // The sounds are really quiet, so I'm compensating for that here
            player.play()
            
            // Stop regular idle animation
            sharkleIdleView.stopAnimating()
            
            // Start waving animation
            sharkleWaveView.animate(withImages: waveImages, andDuration: waveAnimDuration)
            
            // Start bubble animation, after which all animations get reset
            sharkleBubbleView.animate(withImages: bubbleImages, andDuration: bubbleAnimDuration, repeatTimes: 2.5, afterWhich: {
                self.sharkleWaveView.stopAnimating()
                self.sharkleIdleView.animate(withImages: self.idleImages, andDuration: self.idleAnimDuration)
                self.animationIsPlaying = false
            })
        } catch {
            // This should never happen
            // famouslastwords.swift
            print("Error playing audio file")
        }
    }
}

