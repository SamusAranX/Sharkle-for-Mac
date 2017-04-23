//
//  HyperlinkTextField.swift
//  Sharkle
//
//  Created by Peter Wunder on 23.04.17.
//  Copyright © 2017 Peter Wunder. All rights reserved.
//

import Cocoa

class HyperlinkTextField: NSTextField {
    
    var hyperlinkInfos: [[String: Any]] {
        var _hyperlinkInfos = [[String: Any]]()
        let stringRange = NSMakeRange(0, self.attributedStringValue.length)
        
        self.attributedStringValue.enumerateAttribute(NSLinkAttributeName, in: stringRange, options: []) { (value, range, stop) in
            if value != nil {
                var rectCount = 0
                let rectArray = self.textView.layoutManager?.rectArray(forCharacterRange: range, withinSelectedCharacterRange: range, in: self.textView.textContainer!, rectCount: &rectCount)
                for i in 0..<rectCount {
                    let hyperlinkInfoObject = [
                        kHyperlinkInfoCharacterRangeKey : range,
                        kHyperlinkInfoURLKey: value,
                        kHyperlinkInfoRectKey: rectArray![i]
                    ]
                    _hyperlinkInfos.append(hyperlinkInfoObject)
                }
            }
        }
        
        return _hyperlinkInfos
    }
    
    var textView: NSTextView {
        let attributedString = NSMutableAttributedString(attributedString: self.attributedStringValue)
        let font = attributedString.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? NSFont
        if font == nil {
            attributedString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attributedString.length))
        }
        
        let textViewFrame = self.cell?.titleRect(forBounds: self.bounds)
        let textView = NSTextView(frame: textViewFrame!)
        textView.textStorage?.setAttributedString(attributedString)
        
        return textView
    }
    
    let kHyperlinkInfoCharacterRangeKey = "range"
    let kHyperlinkInfoURLKey = "url"
    let kHyperlinkInfoRectKey = "rect"
    
    private func hyperlinkTextFieldInit() {
        self.isEditable = false
        self.isSelectable = false
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.hyperlinkTextFieldInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.hyperlinkTextFieldInit()
    }
    
    private func resetHyperlinkCursorRects() {
        for info in self.hyperlinkInfos {
            let hyperlinkInfoRect = info[kHyperlinkInfoRectKey] as! NSRect
            self.addCursorRect(hyperlinkInfoRect, cursor: NSCursor.pointingHand())
        }
    }
    
    override func resetCursorRects() {
        super.resetCursorRects()
        self.resetHyperlinkCursorRects()
    }
    
    override func mouseUp(with event: NSEvent) {
        let localPoint = self.convert(event.locationInWindow, from: nil)
        let index = self.textView.layoutManager?.characterIndex(for: localPoint, in: self.textView.textContainer!, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if index != NSNotFound {
            for info in self.hyperlinkInfos {
                let range = info[kHyperlinkInfoCharacterRangeKey] as! NSRange
                if NSLocationInRange(index!, range) {
                    let url = info[kHyperlinkInfoURLKey] as! URL
                    NSWorkspace.shared().open(url)
                }
            }
        }
    }
    
}
