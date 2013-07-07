//
//  TBoard.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TBoard.h"
#import "TCell.h"
#import "TGameArray.h"

@implementation TBoard

- (id)initWithFrame:(CGRect)frame andDescription:(UITextView *)desc
{
    self = [super initWithFrame:frame];
    if (self) {
        _end = NO;
        _playersTurn = @1;
        _gameArray = [[TGameArray alloc] initForNewBoard:self];
        _gameDescription = desc;
        [self displayPlayerString];
        [self setBackgroundColor:[UIColor grayColor]];
        for (int j = 0; j < 3; j++) {
            for (int i = 0; i < 3; i++) {
                TCell *v = [[TCell alloc] initWithFrame:
                            CGRectMake((frame.size.width - 3)/3 * i + 3,
                                       (frame.size.height - 3)/3 * j + 3,
                                       (frame.size.width - 3)/3 - 3,
                                       (frame.size.width - 3)/3 - 3)];
                [v setParentBoard:self];
                [v setGameArrayIndex:((i + 1) + (j * 3) - 1)];
                [self addSubview:v];
            }
        }
    }
    return self;
}

- (void)displayPlayerString
{
    NSString *player = [[self playersTurn] isEqual:@1] ? @"X" : @"O";
    [[self gameDescription] setText:[NSString stringWithFormat:@"Player %@'s Turn", player]];
    [[self gameDescription] setNeedsDisplay];
}

- (void)displayWinnerString
{
    [self setEnd:YES];
    NSString *player = [[self playersTurn] isEqual:@1] ? @"X" : @"O";
    [[self gameDescription] setText:[NSString stringWithFormat:@"Player %@ Won!", player]];
    [[self gameDescription] setNeedsDisplay];
}

- (void)displayTieString;
{
    [self setEnd:YES];
    [[self gameDescription] setText:@"Cat's Game. :("];
    [[self gameDescription] setNeedsDisplay];
}

- (void)resetGame
{
    (void) [self initWithFrame:[self frame]
                andDescription:[self gameDescription]];
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
