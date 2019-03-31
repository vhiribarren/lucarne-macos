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

