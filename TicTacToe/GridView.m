//
//  GridView.m
//  TicTacToe
//
//  Created by Jason Hoffman on 12/26/14.
//  Copyright (c) 2014 No5age. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (void)drawRect:(CGRect)rect {
    
    // Draw board 
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:CGPointMake(105, 0)];
    [path addLineToPoint:CGPointMake(105, 320)];
    
    [path moveToPoint:CGPointMake(215, 0)];
    [path addLineToPoint:CGPointMake(215, 320)];
    
    [path moveToPoint:CGPointMake(0, 105)];
    [path addLineToPoint:CGPointMake(320, 105)];
    
    [path moveToPoint:CGPointMake(0, 215)];
    [path addLineToPoint:CGPointMake(320, 215)];
    
    [[UIColor blackColor] setStroke];
    
    [path stroke];
}


@end
