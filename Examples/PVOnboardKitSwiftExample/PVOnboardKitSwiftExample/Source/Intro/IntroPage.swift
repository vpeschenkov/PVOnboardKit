/*
 IntroPage.swift
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

class IntroPage: UIView, OnboardPage {
    public var title: String! {
        get {
            return titleLabel.text
        }
        
        set {
            titleLabel.text = newValue
        }
    }
    
    public var subtitle: String! {
        get {
            return subtitleLabel.text
        }
        
        set {
            subtitleLabel.text = newValue
        }
    }
    
    public var image: UIImage! {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
        }
    }
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.systemFont(ofSize: 17.0)
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        
        imageView = UIImageView()
        self.addSubview(imageView)
        
        subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.font = UIFont.systemFont(ofSize: 16.0)
        subtitleLabel.textColor = UIColor.white
        self.addSubview(subtitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleLabelWidthInsets = CGFloat(48.0)
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(
            width: bounds.size.width - titleLabelWidthInsets,
            height: CGFloat.greatestFiniteMagnitude
        ))
        
        let titleLabelHeightMultiplier = CGFloat(0.14)
        titleLabel.frame = CGRect(
            x: (bounds.size.width - titleLabelSize.width) / 2.0,
            y: bounds.size.height * titleLabelHeightMultiplier - titleLabelSize.height,
            width: titleLabelSize.width,
            height: titleLabelSize.height
        )
        
        if let imageSize = imageView.image?.size {
            let imageViewHeightMultiplier = CGFloat(0.56)
            let imageViewScale = (bounds.size.height * imageViewHeightMultiplier) / imageSize.height
            let imageViewWidth = imageSize.width * imageViewScale
            let imageViewHeight = imageSize.height * imageViewScale
            imageView.frame = CGRect(
                x: (bounds.size.width - imageViewWidth) / 2.0,
                y: titleLabel.frame.maxY,
                width: imageViewWidth,
                height: imageViewHeight
            )
        }
        
        let subtitleLabelWidthInsets = CGFloat(48.0)
        let subtitleLabelSize = subtitleLabel.sizeThatFits(CGSize(
            width: bounds.size.width - subtitleLabelWidthInsets,
            height: CGFloat.greatestFiniteMagnitude
        ))
        
        let subtitleLabelHeightMultiplier = CGFloat(0.18)
        let subtitleYPosition = imageView.frame.maxY + ((bounds.size.height * subtitleLabelHeightMultiplier - subtitleLabelSize.height) / 2.0)
        self.subtitleLabel.frame = CGRect(
            x: (bounds.size.width - subtitleLabelSize.width) / 2.0,
            y: subtitleYPosition,
            width: subtitleLabelSize.width,
            height: subtitleLabelSize.height);
    }
}
