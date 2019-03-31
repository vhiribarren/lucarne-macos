//
//  AppDelegate.swift
//  lucarne-macos
//
//  Created by Vincent Hiribarren on 30/03/2019.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    
    func applicationWillTerminate(_ aNotification: Notification) {
    }

    
    @IBAction func onNewMenuSelected(_ sender: NSMenuItem) {
        let newWindowController = NSStoryboard(name: "Main", bundle: nil)
            .instantiateController(withIdentifier: "SelectionWindow") as? NSWindowController
        newWindowController?.showWindow(self)
    }
    
    
}

