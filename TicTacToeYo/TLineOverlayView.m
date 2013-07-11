//
//  TDrawLine.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/7/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TLineOverlayView.h"

@implementation TLineOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _startPoint = CGPointMake(0, 0);
        _endPoint = CGPointMake(0, 0);
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextSetLineWidth(context, 35.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //start at this point
    CGContextMoveToPoint(context, _startPoint.x, _startPoint.y);
    
    //draw to this point
    CGContextAddLineToPoint(context, _endPoint.x, _endPoint.y);
    
    //draw path
    CGContextStrokePath(context);
}

@end
