//
//  TCell.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBoard.h"

@interface TCell : UIView

@property UIImage *Ximg;
@property UIImage *Oimg;
@property (strong) TBoard *parentBoard;
@property int gameArrayIndex;

- (void)changeSymbol;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end