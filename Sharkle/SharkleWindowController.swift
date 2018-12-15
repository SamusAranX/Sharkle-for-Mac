//
//  SharkleWindowController.swift
//  Sharkle
//
//  Created by Peter Wunder on 21.04.17.
//  Copyright © 2017 Peter Wunder. All rights reserved.
//

import Cocoa

class SharkleWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
		
		(NSApplication.shared.delegate as! AppDelegate).sharkleController = self
        
        // Yes, I'm taking a valid value returned by the system and arbitrarily adding one to it. Sue me.
        // This is the only way to make Sharkle able to intercept clicks.
        self.window?.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.desktopIconWindow)) + 1)
		
        // Make window movable by its background, durr
        self.window?.isMovableByWindowBackground = true
        
        // Make window background transparent
        self.window?.backgroundColor = NSColor(white: 0.5, alpha: 0)
    }

}
