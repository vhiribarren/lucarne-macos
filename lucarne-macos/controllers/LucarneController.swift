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
    
    
    private var refreshInterval: Double = UserDefaults.standard.double(forKey: PrefKey.IMAGE_FREQUENCY)
    private var opacityPercentage: Float = UserDefaults.standard.float(forKey: PrefKey.IMAGE_OPACITY)
    private var timer: Timer?
    
    @IBOutlet weak var imageView: NSImageView!
    
    var targetWindowId: Int? {
        didSet {
            os_log(.debug, log: .lucarneController, "Setting %@ with targetWindowId: %d", String(describing: self), targetWindowId ?? -1)
            startLucarneUpdate()
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSettings), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    
    override func viewDidAppear() {
        super.viewDidAppear()
        os_log(.debug,  log: .lucarneController, "%@", "\(#function)")
        transparentMode()
        updateSettings()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        cancelLucarneUpdate()
    }
    
    
    @objc private func updateSettings() {
        os_log(.debug, log: .lucarneController, "Settings changed, updating parameters")
        let userDefaults = UserDefaults.standard
        // For image alpha value
        imageView.alphaValue = CGFloat(userDefaults.float(forKey: PrefKey.IMAGE_OPACITY))
        // To join all spaces
        if userDefaults.bool(forKey: PrefKey.JOIN_ALL_SPACES) {
            view.window?.collectionBehavior.insert(.canJoinAllSpaces)
        }
        else {
            view.window?.collectionBehavior.remove(.canJoinAllSpaces)
        }
        // For refresh reate
        refreshInterval = 1.0/Double(userDefaults.integer(forKey: PrefKey.IMAGE_FREQUENCY))
        if timer?.isValid == true {
            startLucarneUpdate()
        }
    }
    
    
    private func transparentMode() {
        if let window = view.window {
            window.isOpaque = false
            window.backgroundColor = .clear
            window.isMovableByWindowBackground = true
        }
        else {
            os_log(.error, log: .lucarneController, "window variable is nil")
        }
    }
    
    
    private func startLucarneUpdate() {
        os_log(.debug,  log: .lucarneController, "%@", "\(#function)")
        cancelLucarneUpdate()
        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true, block: { _ in
            self.updateMirroredApp()
        })
    }
    
    
    private func cancelLucarneUpdate() {
        timer?.invalidate()
    }
    
    
    private func updateMirroredApp() {
        guard targetWindowId != nil else {
            os_log(.debug, log: .lucarneController, "targetWindowId variable is nil")
            return
        }
        let windowImage = CGWindowListCreateImage(.null, .optionIncludingWindow, CGWindowID(targetWindowId!), [.boundsIgnoreFraming, .nominalResolution])
        imageView!.image = NSImage(cgImage: windowImage!, size: .zero)
        view.window!.aspectRatio = NSMakeSize(CGFloat((windowImage?.width)!), CGFloat((windowImage?.height)!));
    }
    
    
}
