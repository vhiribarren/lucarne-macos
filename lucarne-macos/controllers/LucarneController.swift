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
        view.window!.aspectRatio = NSMakeSize(CGFloat((windowImage?.width)!), CGFloat((windowImage?.height)!));
    }
    
    
}
