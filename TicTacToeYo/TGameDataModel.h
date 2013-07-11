//
//  TGameArray.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameViewController;

@protocol TGameDataModelDelegate <NSObject>

@property (nonatomic) BOOL endOfGame;

- (NSString *)currentPlayerString;
- (UIColor *)currentPlayerColor;

- (void)drawLineFromRow0:(NSInteger)row0 andColumn0:(NSInteger)column0 toRow1:(NSInteger)row1 andColumn1:(NSInteger)column1;
- (void)displayString:(NSString *)string withColorOrNil:(UIColor *)color;

@end

@interface TGameDataModel : NSObject

@property (nonatomic, readonly) NSInteger currentPlayer;
@property (nonatomic, weak) id <TGameDataModelDelegate> delegate;

- (instancetype)initWithNumberOfRows:(int)rows columns:(int)columns;
- (BOOL)checkIfSymbolPlayedAtRow:(NSInteger)row column:(NSInteger)column;
- (void)playSymbol:(NSInteger)symbol atRow:(NSInteger)row column:(NSInteger)column;

@end