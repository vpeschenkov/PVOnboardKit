/*
 PVIntroViewController.h
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

#import "PVIntroViewController.h"
#import "PVIntroModel.h"
#import "PVIntroView.h"

#import "PVIntroOnboardPage.h"
#import "PVIntroOnboardPageModel.h"

@import PVOnboardKit;

@interface PVIntroViewController ()<PVOnboardViewDelegate, PVOnboardViewDataSource>

@property (nonatomic, strong) PVIntroView *view;
@property (nonatomic, strong) PVIntroModel *model;

@end

@implementation PVIntroViewController
@dynamic view;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.model = [[PVIntroModel alloc] init];
    }
    return self;
}

- (void)loadView {
    self.view = [[PVIntroView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpOnboard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - PVOnboardViewDelegate <NSObject>

- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnLeftActionButtonAtIndex:(NSInteger)index {
    NSLog(NSLocalizedString(@"SKIP", nil));
}

- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnRightActionButtonAtIndex:(NSInteger)index {
    if (index < 2) {
        [onboardView scrollToTheNextPage:YES];
    }
    else {
        NSLog(NSLocalizedString(@"SKIP", nil));
    }
}

#pragma mark - OKOnboardViewDataSource <NSObject>

- (NSInteger)numberOfPagesInOneboardView:(nonnull PVOnboardView *)onboardView {
    return [self.model numberOfPages];
}

- (nonnull UIView<PVOnboardPage> *)onboardView:(nonnull PVOnboardView *)onboardView viewForPageAtIndex:(NSInteger)index {
    PVIntroOnboardPageModel *onboardPageModel = [self.model pageModelForPageAtIndex:index];
    
    PVIntroOnboardPage *onboardPage = [[PVIntroOnboardPage alloc] init];
    onboardPage.title = onboardPageModel.title;
    onboardPage.subtitle = onboardPageModel.subtitle;
    onboardPage.image = [UIImage imageNamed:onboardPageModel.imageName];
    
    return onboardPage;
}

- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideLeftActionButtonForPageAtIndex:(NSInteger)index {
    return [self.model shouldHideLeftActionButtonForPageAtIndex:index];
}

- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForLeftActionButtonAtIndex:(NSInteger)index {
    return [self.model titleForLeftActionButtonAtIndex:index];
}

- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideRightActionButtonForPageAtIndex:(NSInteger)index {
    return [self.model shouldHideLeftActionButtonForPageAtIndex:index];
}

- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForRightActionButtonAtIndex:(NSInteger)index {
    return [self.model titleForRightActionButtonAtIndex:index];
}

#pragma mark - Override Methods

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Private Methods

- (void)setUpOnboard {
    typedef void(^SetUpOnboardActionButtonBlock)(UIButton * _Nonnull actionButton);
    SetUpOnboardActionButtonBlock setUpActionButtonBlock = ^(UIButton * _Nonnull actionButton) {
        actionButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    };
    
    self.view.onboardView.delegate = self;
    self.view.onboardView.dataSource = self;
    
    self.view.onboardView.dotImage = [UIImage imageNamed:@"IntroDotImage"];
    self.view.onboardView.currentDotImage = [UIImage imageNamed:@"IntroCurrentDotImage"];
    
    [self.view.onboardView setUpLeftActionButtonWithBlock:setUpActionButtonBlock];
    [self.view.onboardView setUpRightActionButtonWithBlock:setUpActionButtonBlock];
    
    [self.view.onboardView reloadData];
}

@end
