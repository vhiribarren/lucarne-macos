//
//  ViewController.swift
//  lucarne-macos
//
//  Created by Vincent Hiribarren on 30/03/2019.
//

import os.log
import Cocoa
import CoreGraphics

class CaptureController: NSViewController {

    
    private var captureCommand: CaptureWindowId?
    private var targetWindowId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear() {
        super.viewDidLoad()
        view.window!.level = .floating
    }

    @IBAction func onButtonClicked(_ sender: Any) {
        os_log("Starting capture")
        captureCommand = CaptureWindowId()
        captureCommand?.capture { windowId in
            os_log("%d", windowId)
            self.targetWindowId = windowId
            self.performSegue(withIdentifier: "DisplayLucarne", sender: nil)
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayLucarne" {
            if let destination = segue.destinationController as? LucarneController {
                destination.targetWindowId = targetWindowId
            }
        }
    }

}

