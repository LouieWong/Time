//
//  Topbar.m
//  ContainerDemo
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 WeiZhenLiu. All rights reserved.
//

#import "Topbar.h"
#import "helper.h"
@interface Topbar ()

@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation Topbar

- (void)setTitles:(NSMutableArray *)titles {
    self.showsHorizontalScrollIndicator = NO;
    _titles = titles;
    self.buttons = [NSMutableArray array];
    CGFloat padding = 20.0;
    
    // CGSize contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    for (int i = 0; i < titles.count; i++) {
        
        if ([_titles[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        // buttons
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        // set button frame
        static CGFloat originX = 0;
        CGRect frame = CGRectMake(originX+padding, 0, button.intrinsicContentSize.width, kTopbarHeight);
        button.frame = frame;
        originX      = CGRectGetMaxX(frame) + padding; //originX + padding + button.intrinsicContentSize.width;
        
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.buttons.lastObject frame]) + padding, self.frame.size.height);
    
    // mark view
    UIButton *firstButton = self.buttons.firstObject;
    CGRect frame = firstButton.frame;
//****************************************这里设置，小红线*****************
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(frame)-1, frame.size.width, 2)];
    _markView.backgroundColor = cyanGreen;
    [self addSubview:_markView];
}

/**
- (void)setTitles:(NSMutableArray *)titles {
    _titles = titles;
    self.buttons = [NSMutableArray array];
    CGFloat padding = 20.0;
    CGSize contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);

    for (int i = 0; i < titles.count; i++) {
        if ([_titles[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        // buttons
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // set button frame
        static CGFloat originX = 0;
        CGRect frame = CGRectMake(originX+padding, 0, button.intrinsicContentSize.width, kTopbarHeight);
        button.frame = frame;
        originX      = CGRectGetMaxX(frame) + padding; //originX + padding + button.intrinsicContentSize.width;
        contentSize.width += frame.size.width += padding;
        
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    
    contentSize.width += padding;
    self.contentSize = contentSize;
    
    // mark view
    UIButton *firstButton = self.buttons.firstObject;
    CGRect frame = firstButton.frame;
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(frame)-3, frame.size.width, 3)];
    _markView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_markView];
}
 */

- (void)buttonClick:(id)sender {
    self.currentPage = [self.buttons indexOfObject:sender];
    if (_blockHandler) {
        _blockHandler(_currentPage);
    }
}

// overwrite setter of property: selectedIndex
- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    UIButton *button = [_buttons objectAtIndex:_currentPage];
    CGRect frame = button.frame;
    frame.origin.x -= 5;
    frame.size.width += 10;
    [self scrollRectToVisible:frame animated:YES];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.markView.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame)-1, button.frame.size.width, 2);
      
    } completion:nil];
}

@end
