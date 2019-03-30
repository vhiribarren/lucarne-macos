//
//  ViewController.swift
//  lucarne-macos
//
//  Created by Vincent Hiribarren on 30/03/2019.
//

import os.log
import Cocoa
import CoreGraphics

class ViewController: NSViewController {

    private var captureCommand: CaptureWindowId?
    private var targetWindowId: Int?
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onButtonClicked(_ sender: NSButton) {
        os_log("Starting capture")
        captureCommand = CaptureWindowId()
        captureCommand?.capture { windowId in
            self.targetWindowId = windowId
            os_log("%d", windowId)
            self.updateMirroredApp()
        }
    }
    
    func updateMirroredApp() {
        guard targetWindowId != nil else {
            return
        }
        let windowImage = CGWindowListCreateImage(.null, .optionIncludingWindow, CGWindowID(targetWindowId!), [.boundsIgnoreFraming, .nominalResolution])
        imageView!.image = NSImage(cgImage: windowImage!, size: .zero)
    }
    
}

