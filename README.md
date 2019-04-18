# Lucarne


## About this app

Lucarne copy the content of a window in another window. This new window
float above the others, and it can be resized and put in another MacOS space,
like a tiny vignette.

It can be useful to monitor the content of a window that you let on a MacOS
space, while working in another MacOS Space. For instance you may want to
have a quick look at a Terminal job, while being in another MacOS Space
and doing something else.

Due to MacOS API limitations, and as far as I know, the current method can
take lots of CPU resources. You should avoid having too many Lucarne windows
open, or you should decrease the image capture rate in the preferences if
it takes too much CPU.


## Limitations

If the target window stops its display, it will also be stopped in Lucarne.

It seems an obvious reminder. However, for instance, Chrome and Firefox
quickly stop to refresh their screen when their window is off screen.
As soon as a display is required (for instance with Mission Control) they
start again to refresh their window.

So Lucarne is not a good tool if you want to monitor a browser window. It
is not a limitation of Lucarne, but it is due to the implementation of those
other apps.


## TODO

- App icon
- Try to use AVCaptureScreenInput, and give the choice in the preferences
- Close Lucarne window if target window is closed
- Configuration per window
- List of recent captured window process to quickly capture them again
- Capture per process instead of having to click on a window
- Better interface when capturing a window ID (change of mouse cursor, ...)
- Finish internationalization
- Help Window
- Check if Firefox/Chrom[e|ium] can be configured/modified to continue
  display refresh when they are offscreen

## License

```
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
```