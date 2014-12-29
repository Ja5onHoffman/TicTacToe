//
//  HudView.m
//  TicTacToe
//
//  Created by Jason Hoffman on 12/29/14.
//  Copyright (c) 2014 No5age. All rights reserved.
//

#import "HudView.h"

@implementation HudView

// Taken from another project
+ (instancetype)hudInView:(UIView *)view withMessage:(NSString *)message animated:(BOOL)animated
{
    HudView *hudView = [[HudView alloc] initWithFrame:view.bounds];
    hudView.opaque = NO;
    
    CGRect labelRect = CGRectMake(10, 75, 180, 85);
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    [hudView addSubview:messageLabel];
    messageLabel.center = hudView.center;
    
    dispatch_async(dispatch_get_main_queue(), ^{
         messageLabel.text = message;
    });
    
    [view addSubview:hudView];
    
    return hudView;
}

- (void)drawRect:(CGRect)rect
{
    const CGFloat boxWidth = 192.0f;
    const CGFloat boxHeight = 96.0f;
    
    CGRect boxRect = CGRectMake(
                                roundf(self.bounds.size.width - boxWidth) / 2.0f,
                                roundf(self.bounds.size.height - boxHeight) / 2.0f,
                                boxWidth,
                                boxHeight);
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:boxRect cornerRadius:10.0f];
    [[UIColor colorWithWhite:0.3f alpha:0.8f] setFill];
    [roundedRect fill];
}

@end

