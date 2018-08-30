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
    var players: [AVAudioPlayer] = []
    
    let idleImages: [NSImage] = (0..<8).map {
        let imageName = NSImage.Name("sharkle_idle\($0)")
        return NSImage(named: imageName)!
    }
    let idleAnimDuration = 0.666
    
    let waveImages: [NSImage] = (0..<4).map {
        let imageName = NSImage.Name("sharkle_wave\($0)")
        return NSImage(named: imageName)!
    }
    let waveAnimDuration = 0.4
    
    let bubbleImages: [NSImage] = (0..<2).map {
        let imageName = NSImage.Name("sharkle_bubble\($0)")
        return NSImage(named: imageName)!
    }
    let bubbleAnimDuration = 0.8
    
    let sharkleSounds: [URL] = (0..<8).map({ URL(fileURLWithPath: Bundle.main.path(forResource: "hey_\($0)", ofType: "m4a")!) })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for soundURL in sharkleSounds {
            do {
                let player = try AVAudioPlayer(contentsOf: soundURL)
                player.prepareToPlay()
                player.volume = 1.4
                
                self.players.append(player)
            } catch {
                // This should never happen
                // famouslastwords.swift
                print("Error loading audio file \(soundURL)")
            }
        }
        
        sharkleIdleView.animate(withImages: idleImages, andDuration: idleAnimDuration)
    }
    
    var animationIsPlaying = false
    override func mouseDown(with event: NSEvent) {
        if animationIsPlaying {
            // Sharkle is currently waving, don't interrupt him
            return
        }
        
        animationIsPlaying = true
        
        self.players.randomElement()?.play()
        
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
    }
}

