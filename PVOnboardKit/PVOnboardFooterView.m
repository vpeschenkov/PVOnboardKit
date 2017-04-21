/*
 PVOnboardFooterView.h
 PVOnboardKit
 
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

@import TAPageControl;

#import "PVOnboardFooterView.h"

CGFloat const PVOnboardFooterViewHeight = 64.0f;

@interface PVOnboardFooterView ()

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

@implementation PVOnboardFooterView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize leftActionButtonSize = [self.leftActionButton sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    self.leftActionButton.frame = CGRectMake(self.insets.left,
                                             (self.bounds.size.height - leftActionButtonSize.height) / 2.0f,
                                             leftActionButtonSize.width,
                                             leftActionButtonSize.height);
    
    CGSize rightActionButtonSize = [self.rightActionButton sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    self.rightActionButton.frame = CGRectMake(self.bounds.size.width - rightActionButtonSize.width - self.insets.left,
                                              (self.bounds.size.height - rightActionButtonSize.height) / 2.0f,
                                              rightActionButtonSize.width,
                                              rightActionButtonSize.height);
    
    self.pageControl.frame = CGRectMake((self.bounds.size.width - self.pageControl.bounds.size.width) / 2.0f,
                                        self.bounds.size.height / 2.0f,
                                        self.pageControl.bounds.size.width,
                                        self.pageControl.bounds.size.height);
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, PVOnboardFooterViewHeight);
}

#pragma mark - Event Handlers Methods

- (void)leftActionButtonEventHandler:(UIButton *)button {
    [self.delegate footerViewdidTouchLeftActionButton:self];
}

- (void)rightActionButtonEventHandler:(UIButton *)button {
    [self.delegate footerViewdidTouchRightActionButton:self];
}

#pragma mark - Private Methods

- (void)initViews {
    _leftActionButton = [[UIButton alloc] init];
    _leftActionButton.hidden = YES;
    [_leftActionButton addTarget:self
                          action:@selector(leftActionButtonEventHandler:)
                forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftActionButton];
    
    _rightActionButton = [[UIButton alloc] init];
    _rightActionButton.hidden = YES;
    [_rightActionButton addTarget:self
                           action:@selector(rightActionButtonEventHandler:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightActionButton];
    
    _pageControl = [[TAPageControl alloc] init];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.shouldResizeFromCenter = NO;
    [self addSubview:_pageControl];
}

- (UIEdgeInsets)insets {
    return UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
}

@end
