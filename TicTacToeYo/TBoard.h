//
//  TBoard.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGameArray;

@interface TBoard : UIView

@property BOOL end;
@property NSNumber *playersTurn;
@property TGameArray *gameArray;
@property UITextView *gameDescription;

- (void)displayPlayerString;
- (void)displayWinnerString;
- (void)displayTieString;
- (id)initWithFrame:(CGRect)frame andDescription:(UITextView *)desc;
- (void)resetGame;

@end
