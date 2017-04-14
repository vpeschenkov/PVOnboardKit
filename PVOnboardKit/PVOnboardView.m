/*
 PVOnboardView.m
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

#import "PVOnboardView.h"
#import "PVOnboardPage.h"

@interface PVOnboardView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *leftActionButton;
@property (nonatomic, strong) UIButton *rightActionButton;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TAPageControl *pageControl;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSMutableArray<UIView<PVOnboardPage> *> *views;

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

@implementation PVOnboardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _views = [[NSMutableArray alloc] init];
        
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_backgroundImageView];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
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
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
    
    [self.views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * stop) {
        view.frame = CGRectMake(self.scrollView.bounds.size.width * idx,
                                0.0f,
                                self.scrollView.bounds.size.width,
                                self.scrollView.bounds.size.height);
        [self.scrollView addSubview:view];
    }];
    
    self.scrollView.contentSize = CGSizeMake(self.views.count * self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    CGSize leftActionButtonSize = [self.leftActionButton sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    self.leftActionButton.frame = CGRectMake(self.insets.left,
                                             self.bounds.size.height - leftActionButtonSize.height - self.insets.left - self.insets.right,
                                             leftActionButtonSize.width,
                                             leftActionButtonSize.height);
    
    CGSize rightActionButtonSize = [self.rightActionButton sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    self.rightActionButton.frame = CGRectMake(self.bounds.size.width - rightActionButtonSize.width - self.insets.left,
                                              self.bounds.size.height - rightActionButtonSize.height - self.insets.left - self.insets.right,
                                              rightActionButtonSize.width,
                                              rightActionButtonSize.height);
    
    CGFloat pageControlYAdditionalOffset = 47.0f;
    self.pageControl.frame = CGRectMake((self.bounds.size.width - self.pageControl.bounds.size.width) / 2.0f,
                                        self.bounds.size.height - self.pageControl.bounds.size.height - pageControlYAdditionalOffset,
                                        self.pageControl.bounds.size.width,
                                        self.pageControl.bounds.size.height);
}

#pragma mark - UIScrollViewDelegate<NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSAssert(self.dataSource, @"The data source must be not a nil!");
    
    NSUInteger currentPageIndex = self.pageControl.currentPage;
    NSUInteger nextPageIndex = round(scrollView.contentOffset.x / scrollView.bounds.size.width);
    if (nextPageIndex != currentPageIndex) {
        UIView<PVOnboardPage> *currentPageView = self.views[currentPageIndex];
        UIView<PVOnboardPage> *nextPageView = self.views[nextPageIndex];
        
        if ([currentPageView respondsToSelector:@selector(willContentHide)]) {
            [currentPageView willContentHide];
        }
        
        if ([nextPageView respondsToSelector:@selector(willContentShow)]) {
            [nextPageView willContentShow];
        }
        
        [self setUpActionButtonsWithIndex:nextPageIndex];
        
        self.pageControl.currentPage = nextPageIndex;
        
        if ([currentPageView respondsToSelector:@selector(didContentHide)]) {
            [currentPageView didContentHide];
        }
        
        if ([nextPageView respondsToSelector:@selector(didContentShow)]) {
            [nextPageView didContentShow];
        }
        
        [self setNeedsLayout];
    }
}

#pragma mark - Public Methods

- (void)scrollToTheNextPage:(BOOL)animated {
    NSUInteger currentPageIndex = self.pageControl.currentPage + 1;
    [self.scrollView setContentOffset:CGPointMake(currentPageIndex * self.scrollView.bounds.size.width, 0.0f)
                             animated:YES];
}

- (void)scrollToThePreviouslyPage:(BOOL)animated {
    NSUInteger currentPageIndex = self.pageControl.currentPage - 1;
    [self.scrollView setContentOffset:CGPointMake(currentPageIndex * self.scrollView.bounds.size.width, 0.0f)
                             animated:YES];
}

- (void)reloadData {
    NSAssert(self.dataSource, @"The data source must be not a nil!");
    
    [self.views removeAllObjects];
    
    NSInteger numberOfPagesInOneboardView = [self.dataSource numberOfPagesInOneboardView:self];
    for (NSInteger i = 0; i < numberOfPagesInOneboardView; ++i) {
        [self.views addObject:[self.dataSource onboardView:self viewForPageAtIndex:i]];
    }
    
    NSUInteger pageIndex = self.pageControl.currentPage;
    UIView<PVOnboardPage> *pageView = self.views[pageIndex];
    if ([pageView respondsToSelector:@selector(willContentShow)]) {
        [pageView willContentShow];
    }
    
    [self setUpActionButtonsWithIndex:pageIndex];
    
    if ([pageView respondsToSelector:@selector(didContentShow)]) {
        [pageView didContentShow];
    }
    
    self.pageControl.numberOfPages = numberOfPagesInOneboardView;
    
    [self setNeedsLayout];
}

- (void)setUpLeftActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block {
    block(self.leftActionButton);
}

- (void)setUpRightActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block {
    block(self.rightActionButton);
}

- (Class)dotViewClass {
    return self.pageControl.dotViewClass;
}

- (void)setDotViewClass:(Class)dotViewClass {
    self.pageControl.dotViewClass = dotViewClass;
}

- (UIImage *)dotImage {
    return self.pageControl.dotImage;
}

- (void)setDotImage:(UIImage *)dotImage {
    self.pageControl.dotImage = dotImage;
}

- (UIImage *)currentDotImage {
    return self.pageControl.currentDotImage;
}

- (void)setCurrentDotImage:(UIImage *)currentDotImage {
    self.pageControl.currentDotImage = currentDotImage;
}

- (CGSize)dotSize {
    return self.pageControl.dotSize;
}

- (void)setDotSize:(CGSize)dotSize {
    self.pageControl.dotSize = dotSize;
}

- (NSInteger)spacingBetweenDots {
    return self.spacingBetweenDots;
}

- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots {
    self.pageControl.spacingBetweenDots = spacingBetweenDots;
}

- (UIImage *)backgroundImage {
    return self.backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

- (UIViewContentMode)backgroundImageContentMode {
    return self.backgroundImageView.contentMode;
}

- (void)setBackgroundImageContentMode:(UIViewContentMode)backgroundImageContentMode {
    self.backgroundImageView.contentMode = backgroundImageContentMode;
}

#pragma mark - Event Handlers

- (void)leftActionButtonEventHandler:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(onboardView:didTouchOnLeftActionButtonAtIndex:)]) {
        [self.delegate onboardView:self didTouchOnLeftActionButtonAtIndex:self.pageControl.currentPage];
    }
}

- (void)rightActionButtonEventHandler:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(onboardView:didTouchOnRightActionButtonAtIndex:)]) {
        [self.delegate onboardView:self didTouchOnRightActionButtonAtIndex:self.pageControl.currentPage];
    }
}

#pragma mark - Private Methods

- (UIEdgeInsets)insets {
    return UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
}

- (void)setUpActionButtonsWithIndex:(NSInteger)index {
    // The left action button
    if ([self.dataSource respondsToSelector:@selector(onboardView:shouldHideLeftActionButtonForPageAtIndex:)]) {
        self.leftActionButton.hidden = [self.dataSource onboardView:self shouldHideLeftActionButtonForPageAtIndex:index];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:titleForLeftActionButtonAtIndex:)]) {
        NSString *actionButtonTitle = [self.dataSource onboardView:self titleForLeftActionButtonAtIndex:index];
        [self.leftActionButton setTitle:actionButtonTitle forState:UIControlStateNormal];
        [self.leftActionButton setTitle:actionButtonTitle forState:UIControlStateHighlighted];
        [self.leftActionButton setTitle:actionButtonTitle forState:UIControlStateDisabled];
        [self.leftActionButton setTitle:actionButtonTitle forState:UIControlStateSelected];
        [self.leftActionButton setTitle:actionButtonTitle forState:UIControlStateFocused];
    }
    
    // The right action button
    if ([self.dataSource respondsToSelector:@selector(onboardView:shouldHideRightActionButtonForPageAtIndex:)]) {
        self.rightActionButton.hidden = [self.dataSource onboardView:self shouldHideRightActionButtonForPageAtIndex:index];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:titleForRightActionButtonAtIndex:)]) {
        NSString *actionButtonTitle = [self.dataSource onboardView:self titleForRightActionButtonAtIndex:index];
        [self.rightActionButton setTitle:actionButtonTitle forState:UIControlStateNormal];
        [self.rightActionButton setTitle:actionButtonTitle forState:UIControlStateHighlighted];
        [self.rightActionButton setTitle:actionButtonTitle forState:UIControlStateDisabled];
        [self.rightActionButton setTitle:actionButtonTitle forState:UIControlStateSelected];
        [self.rightActionButton setTitle:actionButtonTitle forState:UIControlStateFocused];
    }
}

@end
