//
//  ReplaceControllerSegue.swift
//  Lucarne
//
//  Created by Vincent Hiribarren on 31/03/2019.
//

import Cocoa

class ReplaceControllerSegue: NSStoryboardSegue {
    
    override func perform() {
        if let fromViewController = sourceController as? NSViewController {
            if let toViewController = destinationController as? NSViewController {
                toViewController.view.frame.size = fromViewController.view.frame.size
                fromViewController.view.window?.contentViewController = toViewController
            }
        }
    }

}
