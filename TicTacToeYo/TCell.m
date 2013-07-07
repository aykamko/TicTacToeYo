//
//  TCell.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TCell.h"
#import "TGameArray.h"

@implementation TCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setOimg:[UIImage imageNamed:@"Supporting Files/Default.png"]];
        [self setXimg:[UIImage imageNamed:@"img.bundle/TTT_X.png"]];
    }
    return self;
}

- (void)changeSymbol {
    TBoard *pB = [self parentBoard];
    NSNumber *turn = [pB playersTurn];
    if ([self backgroundColor] == [UIColor whiteColor]) {
        if ([turn isEqualToNumber:@1]) {
            [[self Ximg] drawAtPoint:[self center]];
            [self setBackgroundColor:[UIColor greenColor]];
            [pB setPlayersTurn:@2];
            [[pB gameArray] setObject:@1 toIndex:[self gameArrayIndex]];
        } else if ([turn isEqualToNumber:@2]) {
            [self setBackgroundColor:[UIColor redColor]];
            [pB setPlayersTurn:@1];
            [[pB gameArray] setObject:@2 toIndex:[self gameArrayIndex]];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![[self parentBoard] end])
    {
        [self changeSymbol];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
