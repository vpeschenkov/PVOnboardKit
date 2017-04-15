/*
 IntroViewController.swift
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
import PVOnboardKit

class IntroViewController: UIViewController {
    private (set) lazy var model: IntroModel! = {
        return IntroModel()
    }()
    
    private (set) lazy var introView: IntroView! = {
        return IntroView()
    }()
    
    override func loadView() {
        view = self.introView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        setUpOnboard()
    }
    
    private func setUpOnboard() {
        let setUpActionButtonBlock: PVOnboardViewConfigureActionButtonBlock = {
            (button) in
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.white, for: .highlighted)
        }
        
        introView.onboardView.delegate = self
        introView.onboardView.dataSource = self
        
        introView.onboardView.dotImage = #imageLiteral(resourceName: "IntroDotImage")
        introView.onboardView.currentDotImage = #imageLiteral(resourceName: "IntroCurrentDotImage")
        
        introView.onboardView.setUpLeftActionButtonWith(setUpActionButtonBlock)
        introView.onboardView.setUpRightActionButtonWith(setUpActionButtonBlock)
        
        introView.onboardView.reloadData()
    }
}

extension IntroViewController: PVOnboardViewDelegate {
    func onboardView(_ onboardView: PVOnboardView, didTouchOnLeftActionButtonAt index: Int) {
        NSLog(NSLocalizedString("SKIP", comment: ""))
    }
    
    func onboardView(_ onboardView: PVOnboardView, didTouchOnRightActionButtonAt index: Int) {
        if index < 2 {
            onboardView.scroll(toTheNextPage: true)
        }
        else {
            NSLog(NSLocalizedString("SKIP", comment: ""))
        }
    }
}

extension IntroViewController: PVOnboardViewDataSource {
    public func numberOfPages(inOneboardView onboardView: PVOnboardView) -> Int {
        return model.numberOfPages()
    }

    public func onboardView(_ onboardView: PVOnboardView, viewForPageAt index: Int) -> UIView {
        let pageModel = model.pageModel(forPageAtIndex: index)
        
        let page = IntroPage()
        page.title = pageModel.title
        page.subtitle = pageModel.subtitle
        page.image = UIImage(named: pageModel.imageName)
        
        return page
    }
    
    public func onboardView(_ onboardView: PVOnboardView, shouldHideRightActionButtonForPageAt index: Int) -> Bool {
        return model.shouldHideRightActionButton(forPageAtIndex: index)
    }
    
    public func onboardView(_ onboardView: PVOnboardView, titleForRightActionButtonAt index: Int) -> String?  {
        return model.titleForRightActionButton(atIndex: index)
    }
    
    public func onboardView(_ onboardView: PVOnboardView, shouldHideLeftActionButtonForPageAt index: Int) -> Bool {
        return model.shouldHideLeftActionButton(forPageAtIndex: index)
    }
    
    public func onboardView(_ onboardView: PVOnboardView, titleForLeftActionButtonAt index: Int) -> String? {
        return model.titleForLeftActionButton(atIndex: index)
    }
}
