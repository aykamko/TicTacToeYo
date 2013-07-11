//
//  TBoardView.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBoardViewDelegate <NSObject>

@property (nonatomic, readonly) BOOL endOfGame;
@property (nonatomic, strong, readonly) NSString *currentPlayerString;
@property (nonatomic, strong, readonly) UIColor *currentPlayerColor;

- (void)playSymbol:(NSString *)symbol atRow:(NSInteger)row column:(NSInteger)column;
- (BOOL)checkIfSymbolPlayedAtRow:(NSInteger)row column:(NSInteger)column;

@end


@interface TBoardView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) id <TBoardViewDelegate> delegate;

- (void)drawLineFromRow0:(NSInteger)row0 andColumn0:(NSInteger)column0 toRow1:(NSInteger)row1 andColumn1:(NSInteger)column1;
- (void)displayCellSymbol:(NSString *)symbol atRow:(NSInteger)row column:(NSInteger)column;
- (void)reset;

@end
