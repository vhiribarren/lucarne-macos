//
//  LucarneController.swift
//  Lucarne
//
//  Created by Vincent Hiribarren on 30/03/2019.
//

import os.log
import Cocoa

class LucarneController: NSViewController {

    
    let REFRESH_INTERVAL = TimeInterval(1.0/4.0)
    
    
    var targetWindowId: Int? {
        didSet {
            os_log("Setting targetWindowId")
            startLucarneUpdate()
        }
    }
    
    
    private var timer: Timer?
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidAppear()
    }
    
    
    override func viewDidAppear() {
        super.viewDidLoad()
        //view.window!.styleMask.remove(.titled)
    }
    

    
    override func viewWillDisappear() {
        cancelLucarneUpdate()
    }
    
    private func startLucarneUpdate() {
        cancelLucarneUpdate()
        timer = Timer.scheduledTimer(withTimeInterval: REFRESH_INTERVAL, repeats: true, block: { _ in
            self.updateMirroredApp()
        })
    }
    
    
    private func cancelLucarneUpdate() {
        timer?.invalidate()
    }
    
    
    private func updateMirroredApp() {
        guard targetWindowId != nil else {
            return
        }
        let windowImage = CGWindowListCreateImage(.null, .optionIncludingWindow, CGWindowID(targetWindowId!), [.boundsIgnoreFraming, .nominalResolution])
        imageView!.image = NSImage(cgImage: windowImage!, size: .zero)
    }
    
    
}
