//
//  CaptureWindowId.swift
//  lucarne-macos
//
//  Created by Vincent Hiribarren on 30/03/2019.
//

import os.log
import EventKit
import Foundation

class CaptureWindowId {
    
    private var _monitor: Any?
    
    func capture(callback: @escaping (Int) -> Void) {
        guard _monitor == nil else {
            os_log(.error, "Already set to capture, ignoring command")
            return
        }
        _monitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { event in
            callback(event.windowNumber)
            self.cleanMonitor()
        }
    }
    
    private func cleanMonitor() {
        if _monitor != nil {
            NSEvent.removeMonitor(_monitor!)
            _monitor = nil
        }
    }
    
}
