/*
 PVIntroModel.m
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

#import "PVIntroModel.h"
#import "PVIntroOnboardPageModel.h"

@interface PVIntroModel ()

@property (nonatomic, strong) NSMutableArray<PVIntroOnboardPageModel *> *pages;

@end

@implementation PVIntroModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _pages = [[NSMutableArray alloc] init];
        
        [_pages addObject:[PVIntroOnboardPageModel onboardPageModelWithTitle:NSLocalizedString(@"mars.title", nil)
                                                                    subtitle:NSLocalizedString(@"mars.subtitle", nil)
                                                                   imageName:@"IntroIMarsImage"]];
        
        [_pages addObject:[PVIntroOnboardPageModel onboardPageModelWithTitle:NSLocalizedString(@"venus.title", nil)
                                                                    subtitle:NSLocalizedString(@"venus.subtitle", nil)
                                                                   imageName:@"IntroVenusImage"]];
        
        [_pages addObject:[PVIntroOnboardPageModel onboardPageModelWithTitle:NSLocalizedString(@"jupiter.title", nil)
                                                                    subtitle:NSLocalizedString(@"jupiter.subtitle", nil)
                                                                   imageName:@"IntroJupiterImage"]];
    }
    return self;
}

#pragma mark - Public Methods

- (NSInteger)numberOfPages {
    return self.pages.count;
}

- (nonnull PVIntroOnboardPageModel *)pageModelForPageAtIndex:(NSInteger)index {
    return self.pages[index];
}

- (BOOL)shouldHideLeftActionButtonForPageAtIndex:(NSInteger)index {
    return NO;
}

- (nullable NSString *)titleForLeftActionButtonAtIndex:(NSInteger)index {
    return index < 2 ? NSLocalizedString(@"SKIP", nil) : @"";
}

- (BOOL)shouldHideRightActionButtonForPageAtIndex:(NSInteger)index {
    return NO;
}

- (nullable NSString *)titleForRightActionButtonAtIndex:(NSInteger)index {
    return index == 2 ? NSLocalizedString(@"START", nil) : NSLocalizedString(@"NEXT", nil);
}


@end
