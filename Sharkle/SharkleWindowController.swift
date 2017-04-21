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
        
        // Yes, I'm taking a valid value returned by the system and adding one to it. Sue me.
        // This is the only way to make Sharkle able to intercept clicks.
        self.window?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.desktopIconWindow)) + 1
        
        self.window?.isMovableByWindowBackground = true
        self.window?.backgroundColor = NSColor(white: 0.5, alpha: 0)
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
