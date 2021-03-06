/*
 MIT License
 
 Copyright (c) 2019 Vincent Hiribarren
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */


import os.log
import EventKit
import Foundation

class CaptureWindowId {
    
    private var _monitor: Any?
    
    func capture(callback: @escaping (Int) -> Void) {
        guard _monitor == nil else {
            os_log(.error, log: .captureAction, "Already set to capture, ignoring command")
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
