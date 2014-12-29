//
//  HudView.h
//  TicTacToe
//
//  Created by Jason Hoffman on 12/29/14.
//  Copyright (c) 2014 No5age. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView

+ (instancetype)hudInView:(UIView *)view withMessage:(NSString *)message animated:(BOOL)animated;

@property (nonatomic, strong) NSString *text;

@end
