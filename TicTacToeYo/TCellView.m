//
//  TCell.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TCellView.h"
#import "TGameDataModel.h"

@implementation TCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)drawX
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(context, 20.0);
    
    CGPoint startPoint1 = CGPointMake(10, 10);
    CGPoint endPoint1 = CGPointMake(self.bounds.size.width - 10,
                                    self.bounds.size.height - 10);
    CGPoint startPoint2 = CGPointMake(self.bounds.size.width - 10,
                                      10);
    CGPoint endPoint2 = CGPointMake(10,
                                    self.bounds.size.height - 10);
    
    CGContextMoveToPoint(context, startPoint1.x, startPoint1.y);
    CGContextAddLineToPoint(context, endPoint1.x, endPoint1.y);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, startPoint2.x, startPoint2.y);
    CGContextAddLineToPoint(context, endPoint2.x, endPoint2.y);
    CGContextStrokePath(context);
}

- (void)drawO
{
        CGRect bounds = [self bounds];
        CGPoint center;
        
        center.x = bounds.origin.x + bounds.size.width / 2.0;
        center.y = bounds.origin.y + bounds.size.height / 2.0;
        
        float maxRadius = hypot(bounds.size.width, bounds.size.height) / 4.0;
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        
        [path addArcWithCenter:center
                        radius:maxRadius - 0.6
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
        
        [path setLineWidth:18];
        
        [[[UIColor alloc] initWithRed:0
                               green:0.6
                                 blue:0
                                alpha:1] setStroke];
        
        [path stroke];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([_symbol isEqualToString:@"X"]) {
        [self drawX];
        return;
    } else if ([_symbol isEqualToString:@"O"]) {
        [self drawO];
        return;
    }
    // Else draw nothing
}

@end
