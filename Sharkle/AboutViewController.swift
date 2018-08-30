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
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var aboutLabel: HyperlinkTextField!
    
    @IBOutlet weak var githubLabel: HyperlinkTextField!
    @IBOutlet weak var bugsLabel: HyperlinkTextField!
    @IBOutlet weak var twitterLabel: HyperlinkTextField!
    
    let hyperlinksInText = [
        "Night in the Woods": URL(string: "http://nightinthewoods.com")!,
        "this part of Jesse Cox's playthrough": URL(string: "https://www.youtube.com/watch?v=d86WnX_271U&feature=youtu.be&t=1h34m30s")!
    ]
    
    let hyperlinksForLabels = [
        URL(string: "https://github.com/SamusAranX/Sharkle-for-Mac")!,
        URL(string: "https://github.com/SamusAranX/Sharkle-for-Mac")!,
        URL(string: "https://twitter.com/SamusAranX")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fill in the version number
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        versionLabel.stringValue = "v\(version)"
        
        // Configure hyperlinks in multi-line label
        let aboutString = NSString(string: aboutLabel.stringValue)
        let aboutAttrString = NSMutableAttributedString(string: aboutLabel.stringValue)
        for hyperlink in hyperlinksInText {
            let range = aboutString.range(of: hyperlink.key)
            aboutAttrString.addAttribute(NSAttributedString.Key.link, value: hyperlink.value, range: range)
        }
        
        aboutLabel.attributedStringValue = aboutAttrString
        
        // Configure hyperlinks in smaller labels
        let githubAttrString = githubLabel.stringValue.hyperlink(with: hyperlinksForLabels[0])
        githubLabel.attributedStringValue = githubAttrString
        
        let bugsAttrString = bugsLabel.stringValue.hyperlink(with: hyperlinksForLabels[1])
        bugsLabel.attributedStringValue = bugsAttrString
        
        let twitterAttrString = twitterLabel.stringValue.hyperlink(with: hyperlinksForLabels[2])
        twitterLabel.attributedStringValue = twitterAttrString
    }
    
}
