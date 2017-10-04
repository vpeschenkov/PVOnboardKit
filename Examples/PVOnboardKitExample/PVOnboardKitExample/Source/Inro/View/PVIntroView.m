/*
 PVIntroView.m
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

#import "PVIntroView.h"

@import PVOnboardKit;

@implementation PVIntroView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        _onboardView = [[PVOnboardView alloc] init];
        _onboardView.backgroundColor = [UIColor blackColor];
        [self addSubview:_onboardView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat onboardViewX = 0.0f;
    CGFloat onboardViewY = 0.0f;
    CGFloat onboardViewWidth = self.bounds.size.width;
    CGFloat onboardViewHeight = self.bounds.size.height;
    if (@available(iOS 11, *)) {
        onboardViewY = self.safeAreaInsets.top;
        onboardViewWidth = self.bounds.size.width - self.safeAreaInsets.left - self.safeAreaInsets.right;
        onboardViewHeight = self.bounds.size.height - self.safeAreaInsets.top - self.safeAreaInsets.bottom;
    }
    self.onboardView.frame = CGRectMake(onboardViewX, onboardViewY, onboardViewWidth, onboardViewHeight);
}

@end
