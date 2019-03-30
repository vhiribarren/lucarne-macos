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

    let REFRESH_INTERVAL = TimeInterval(1.0/4.0)
    
    private var captureCommand: CaptureWindowId?
    private var targetWindowId: Int?
    private var timer: Timer?
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear() {
        timer?.invalidate()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onButtonClicked(_ sender: Any) {
        os_log("Starting capture")
        captureCommand = CaptureWindowId()
        captureCommand?.capture { windowId in
            self.targetWindowId = windowId
            os_log("%d", windowId)
            self.startMirroredAppUpdate()
        }
    }
    
    func startMirroredAppUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: REFRESH_INTERVAL, repeats: true, block: { _ in
            self.updateMirroredApp()
        })
    }
    
    func updateMirroredApp() {
        guard targetWindowId != nil else {
            return
        }
        let windowImage = CGWindowListCreateImage(.null, .optionIncludingWindow, CGWindowID(targetWindowId!), [.boundsIgnoreFraming, .nominalResolution])
        imageView!.image = NSImage(cgImage: windowImage!, size: .zero)
    }
    
}

