//
//  AboutViewController.swift
//  Sharkle
//
//  Created by Peter Wunder on 21.04.17.
//  Copyright © 2017 Peter Wunder. All rights reserved.
//

import Cocoa

class AboutViewController: NSViewController {
    
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var horizontalLine: NSView!
    @IBOutlet weak var versionLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.white.cgColor
        
        horizontalLine.wantsLayer = true
        horizontalLine.layer?.backgroundColor = NSColor(white: 0.8666, alpha: 1).cgColor
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        versionLabel.stringValue = "v\(version)"
        
        
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        let url = URL(string: "http://www.nightinthewoods.com")!
        NSWorkspace.shared().open(url)
    }
    
    @IBAction func playthroughButton(_ sender: Any) {
        let url = URL(string: "https://www.youtube.com/watch?v=d86WnX_271U&feature=youtu.be&t=1h34m30s")!
        NSWorkspace.shared().open(url)
    }
    
    @IBAction func sourceButton(_ sender: Any) {
        let url = URL(string: "https://github.com/SamusAranX/Sharkle/")!
        NSWorkspace.shared().open(url)
    }
    
    @IBAction func bugsButton(_ sender: Any) {
        let url = URL(string: "https://github.com/SamusAranX/Sharkle/issues")!
        NSWorkspace.shared().open(url)
    }
    
    @IBAction func praiseButton(_ sender: Any) {
        let url = URL(string: "https://twitter.com/SamusAranX")!
        NSWorkspace.shared().open(url)
    }
    
}
