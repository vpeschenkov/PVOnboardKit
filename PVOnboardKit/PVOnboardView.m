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

#import "PVOnboardView.h"
#import "PVOnboardPage.h"
#import "PVOnboardFooterView.h"

@import TAPageControl;

@interface PVOnboardView ()<UIScrollViewDelegate, PVOnboardFooterViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) PVOnboardFooterView *footerView;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSMutableArray<UIView *> *views;

@property (nonatomic, readonly) CGFloat footerBottomPadding;

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

@implementation PVOnboardView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViewsWithFooterView:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewsWithFooterView:nil];
    }
    return self;
}

- (instancetype)initWithFooterView:(PVOnboardFooterView *)footerView {
    self = [super init];
    if (self) {
        [self initViewsWithFooterView:footerView];
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
    
    CGSize footerViewSize = [self.footerView sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    self.footerView.frame = CGRectMake(0.0f,
                                       self.bounds.size.height - footerViewSize.height - self.footerBottomPadding,
                                       footerViewSize.width,
                                       footerViewSize.height);
    
    self.scrollView.contentSize = CGSizeMake(self.views.count * self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
}

#pragma mark - UIScrollViewDelegate<NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSAssert(self.dataSource, @"The data source must be not null!");
    
    NSUInteger currentPageIndex = self.footerView.pageControl.currentPage;
    NSUInteger nextPageIndex = round(scrollView.contentOffset.x / scrollView.bounds.size.width);
    if (nextPageIndex != currentPageIndex) {
        UIView *currentPageView = self.views[currentPageIndex];
        UIView *nextPageView = self.views[nextPageIndex];
        
        if ([currentPageView conformsToProtocol:@protocol(PVOnboardPage)]) {
            UIView<PVOnboardPage> *page = (UIView<PVOnboardPage> *)currentPageView;
            if ([page respondsToSelector:@selector(willContentHide)]) {
                [page willContentHide];
            }
        }
        
        if ([nextPageView conformsToProtocol:@protocol(PVOnboardPage)]) {
            UIView<PVOnboardPage> *page = (UIView<PVOnboardPage> *)nextPageView;
            if ([page respondsToSelector:@selector(willContentShow)]) {
                [page willContentShow];
            }
        }
        
        [self setUpActionButtonsWithIndex:nextPageIndex];
        
        self.footerView.pageControl.currentPage = nextPageIndex;
        
        if ([currentPageView conformsToProtocol:@protocol(PVOnboardPage)]) {
            UIView<PVOnboardPage> *page = (UIView<PVOnboardPage> *)currentPageView;
            if ([page respondsToSelector:@selector(didContentHide)]) {
                [page didContentHide];
            }
        }
        
        if ([nextPageView conformsToProtocol:@protocol(PVOnboardPage)]) {
            UIView<PVOnboardPage> *page = (UIView<PVOnboardPage> *)nextPageView;
            if ([page respondsToSelector:@selector(didContentShow)]) {
                [page didContentShow];
            }
        }
        
        [self setNeedsLayout];
    }
}

#pragma mark - Public Methods

- (void)scrollToNextPage:(BOOL)animated {
    NSUInteger currentPageIndex = self.footerView.pageControl.currentPage + 1;
    [self.scrollView setContentOffset:CGPointMake(currentPageIndex * self.scrollView.bounds.size.width, 0.0f)
                             animated:YES];
}

- (void)scrollToPreviouslyPage:(BOOL)animated {
    NSUInteger currentPageIndex = self.footerView.pageControl.currentPage - 1;
    [self.scrollView setContentOffset:CGPointMake(currentPageIndex * self.scrollView.bounds.size.width, 0.0f)
                             animated:YES];
}

- (void)reloadData {
    NSAssert(self.dataSource, @"The data source must be not null!");
    
    [self.views removeAllObjects];
    
    NSInteger numberOfPagesInOneboardView = [self.dataSource numberOfPagesInOneboardView:self];
    for (NSInteger i = 0; i < numberOfPagesInOneboardView; ++i) {
        [self.views addObject:[self.dataSource onboardView:self viewForPageAtIndex:i]];
    }
    
    NSUInteger pageIndex = self.footerView.pageControl.currentPage;
    UIView *pageView = self.views[pageIndex];
    
    if ([pageView conformsToProtocol:@protocol(PVOnboardPage)]) {
        UIView<PVOnboardPage> *page = (UIView<PVOnboardPage> *)pageView;
        if ([page respondsToSelector:@selector(willContentShow)]) {
            [page willContentShow];
        }
    }
    
    [self setUpActionButtonsWithIndex:pageIndex];
    
    if ([pageView conformsToProtocol:@protocol(PVOnboardPage)]) {
        UIView<PVOnboardPage> *page = (UIView<PVOnboardPage> *)pageView;
        if ([page respondsToSelector:@selector(didContentShow)]) {
            [page didContentShow];
        }
    }
    
    self.footerView.pageControl.numberOfPages = numberOfPagesInOneboardView;
    
    [self setNeedsLayout];
}

- (void)setUpLeftActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block {
    block(self.footerView.leftActionButton);
}

- (void)setUpRightActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block {
    block(self.footerView.rightActionButton);
}

- (Class)dotViewClass {
    return self.footerView.pageControl.dotViewClass;
}

- (void)setDotViewClass:(Class)dotViewClass {
    self.footerView.pageControl.dotViewClass = dotViewClass;
}

- (UIImage *)dotImage {
    return self.footerView.pageControl.dotImage;
}

- (void)setDotImage:(UIImage *)dotImage {
    self.footerView.pageControl.dotImage = dotImage;
}

- (UIImage *)currentDotImage {
    return self.footerView.pageControl.currentDotImage;
}

- (void)setCurrentDotImage:(UIImage *)currentDotImage {
    self.footerView.pageControl.currentDotImage = currentDotImage;
}

- (CGSize)dotSize {
    return self.footerView.pageControl.dotSize;
}

- (void)setDotSize:(CGSize)dotSize {
    self.footerView.pageControl.dotSize = dotSize;
}

- (NSInteger)spacingBetweenDots {
    return self.spacingBetweenDots;
}

- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots {
    self.footerView.pageControl.spacingBetweenDots = spacingBetweenDots;
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

#pragma mark - PVOnboardFooterViewDelegate <NSObject>

- (void)footerViewdidTouchLeftActionButton:(nonnull PVOnboardFooterView *)footerView {
    if ([self.delegate respondsToSelector:@selector(onboardView:didTouchOnLeftActionButtonAtIndex:)]) {
        [self.delegate onboardView:self didTouchOnLeftActionButtonAtIndex:self.footerView.pageControl.currentPage];
    }
}

- (void)footerViewdidTouchRightActionButton:(nonnull PVOnboardFooterView *)footerView {
    if ([self.delegate respondsToSelector:@selector(onboardView:didTouchOnRightActionButtonAtIndex:)]) {
        [self.delegate onboardView:self didTouchOnRightActionButtonAtIndex:self.footerView.pageControl.currentPage];
    }
}

#pragma mark - Private Methods

- (void)initViewsWithFooterView:(PVOnboardFooterView *)footerView {
    _views = [[NSMutableArray alloc] init];
    
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_backgroundImageView];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _footerView = footerView ? footerView : [[PVOnboardFooterView alloc] init];
    _footerView.delegate = self;
    [self addSubview:_footerView];
}

- (UIEdgeInsets)insets {
    return UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
}

- (CGFloat)footerBottomPadding {
    if ([self.dataSource respondsToSelector:@selector(onboardViewFooterBottomPadding:)]) {
        return [self.dataSource onboardViewFooterBottomPadding:self];
    }
    return 0.0f;
}

- (void)setUpActionButtonsWithIndex:(NSInteger)index {
    [self setUpLeftActionButtonsWithIndex:index];
    [self setUpRightActionButtonsWithIndex:index];
    
    // Update the footer view
    [self.footerView setNeedsLayout];
}

- (void)setUpLeftActionButtonsWithIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(onboardView:shouldHideLeftActionButtonForPageAtIndex:)]) {
        self.footerView.leftActionButton.hidden = [self.dataSource onboardView:self
                                      shouldHideLeftActionButtonForPageAtIndex:index];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:titleForLeftActionButtonAtIndex:)]) {
        NSString *title = [self.dataSource onboardView:self titleForLeftActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.leftActionButton
                      withTitle:title];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:titleEdgeInsetsForLeftActionButtonAtIndex:)]) {
        UIEdgeInsets edgeInsets = [self.dataSource onboardView:self titleEdgeInsetsForLeftActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.leftActionButton
            withTitleEdgeInsets:edgeInsets];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:imageForLeftActionButtonAtIndex:)]) {
        UIImage *image = [self.dataSource onboardView:self imageForLeftActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.leftActionButton
                      withImage:image];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:imageEdgeInsetsForLeftActionButtonAtIndex:)]) {
        UIEdgeInsets edgeInsets = [self.dataSource onboardView:self imageEdgeInsetsForLeftActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.leftActionButton
            withImageEdgeInsets:edgeInsets];
    }
}

- (void)setUpRightActionButtonsWithIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(onboardView:shouldHideRightActionButtonForPageAtIndex:)]) {
        self.footerView.rightActionButton.hidden = [self.dataSource onboardView:self
                                      shouldHideRightActionButtonForPageAtIndex:index];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:titleForRightActionButtonAtIndex:)]) {
        NSString *title = [self.dataSource onboardView:self titleForRightActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.rightActionButton
                      withTitle:title];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:titleEdgeInsetsForRightActionButtonAtIndex:)]) {
        UIEdgeInsets edgeInsets = [self.dataSource onboardView:self titleEdgeInsetsForRightActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.rightActionButton
            withTitleEdgeInsets:edgeInsets];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:imageForRightActionButtonAtIndex:)]) {
        UIImage *image = [self.dataSource onboardView:self imageForRightActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.rightActionButton
                      withImage:image];
    }
    
    if ([self.dataSource respondsToSelector:@selector(onboardView:imageEdgeInsetsForRightActionButtonAtIndex:)]) {
        UIEdgeInsets edgeInsets = [self.dataSource onboardView:self imageEdgeInsetsForRightActionButtonAtIndex:index];
        [self setUpActionButton:self.footerView.rightActionButton
            withImageEdgeInsets:edgeInsets];
    }
}

- (void)setUpActionButton:(UIButton *)actionButton
                withTitle:(NSString *)title {
    [actionButton setTitle:title forState:UIControlStateNormal];
    [actionButton setTitle:title forState:UIControlStateHighlighted];
    [actionButton setTitle:title forState:UIControlStateDisabled];
    [actionButton setTitle:title forState:UIControlStateSelected];
    [actionButton setTitle:title forState:UIControlStateFocused];
}

- (void)setUpActionButton:(UIButton *)actionButton
      withTitleEdgeInsets:(UIEdgeInsets)edgeInsets {
    actionButton.titleEdgeInsets = edgeInsets;
}

- (void)setUpActionButton:(UIButton *)actionButton
                withImage:(UIImage *)image {
    [actionButton setImage:image forState:UIControlStateNormal];
    [actionButton setImage:image forState:UIControlStateHighlighted];
    [actionButton setImage:image forState:UIControlStateDisabled];
    [actionButton setImage:image forState:UIControlStateSelected];
    [actionButton setImage:image forState:UIControlStateFocused];
}

- (void)setUpActionButton:(UIButton *)actionButton
      withImageEdgeInsets:(UIEdgeInsets)edgeInsets {
    actionButton.imageEdgeInsets = edgeInsets;
}

@end
