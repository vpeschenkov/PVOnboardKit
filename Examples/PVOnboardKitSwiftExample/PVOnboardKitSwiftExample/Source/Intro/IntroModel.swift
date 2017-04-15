/*
 IntroModel.swift
 PVOnboardKitExample
 
 Copyright 2017 Victor Peschenkov
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

class IntroModel {
    public lazy var pages: [IntroPageModel] = {
        var pages = [IntroPageModel]()
        pages.append(IntroPageModel.pageModel(
            withTitle: NSLocalizedString("mars.title", comment: ""),
            subtitle: NSLocalizedString("mars.subtitle", comment: ""),
            imageName: "IntroIMarsImage"
        ))
        pages.append(IntroPageModel.pageModel(
            withTitle: NSLocalizedString("venus.title", comment: ""),
            subtitle: NSLocalizedString("venus.subtitle", comment: ""),
            imageName: "IntroVenusImage"
        ))
        pages.append(IntroPageModel.pageModel(
            withTitle: NSLocalizedString("jupiter.title", comment: ""),
            subtitle: NSLocalizedString("jupiter.subtitle", comment: ""),
            imageName: "IntroJupiterImage"
        ))
        return pages
    }()
    
    func numberOfPages() -> Int {
        return pages.count
    }
    
    func pageModel(forPageAtIndex index: Int) -> IntroPageModel {
        return pages[index]
    }
    
    func shouldHideLeftActionButton(forPageAtIndex index: Int) -> Bool {
        return false
    }
    
    func titleForLeftActionButton(atIndex index: Int) -> String {
        return index < 2 ? NSLocalizedString("SKIP", comment: "") : ""
    }
    
    func shouldHideRightActionButton(forPageAtIndex index: Int) -> Bool {
        return false
    }
    
    func titleForRightActionButton(atIndex index: Int) -> String {
        return index < 2 ? NSLocalizedString("START", comment: "") : NSLocalizedString("NEXT", comment: "")
    }
}
