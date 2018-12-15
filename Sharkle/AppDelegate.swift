//
//  AppDelegate.swift
//  Sharkle
//
//  Created by Peter Wunder on 20.04.17.
//  Copyright © 2017 Peter Wunder. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	weak var sharkleController: SharkleWindowController!

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

	@IBAction func resetSharklePosition(_ sender: NSMenuItem) {
		if let window = self.sharkleController.window {
			window.setFrameOrigin(NSPoint(x: 24, y: 24))
		}
	}
	
}

