//
//  TGameBoard.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TGameDataModel.h"
#import "TBoardView.h"
#import "TLineOverlayView.h"

typedef NS_ENUM(NSUInteger, GamePlayer) {
    GamePlayerNone,
    GamePlayer1,
    GamePlayer2
};

@interface TGameDataModel ()

@property int rowCount;
@property int columnCount;
@property (nonatomic) BOOL endOfGame;
@property NSMutableArray *dataArray;

- (void)changePlayers;

@end

@implementation TGameDataModel

- (instancetype)init
{
    self = [self initWithNumberOfRows:3 columns:3];
    return self;
}

- (instancetype)initWithNumberOfRows:(int)rows columns:(int)columns
{
    self = [super init];
    if (self != nil) {
        // Initializing empty array
        _rowCount = rows;
        _columnCount = columns;
        _dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < rows; i++) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (int j = 0; j < columns; j++) {
                [tempArray addObject:@0];
            }
            [_dataArray addObject:tempArray];
        }
        [self setEndOfGame:NO];
        _currentPlayer = GamePlayer1;
    }
    return self;
}

- (void)setDelegate:(id<TGameDataModelDelegate>)delegate
{
    _delegate = delegate;
    NSString *displayString = [NSString
                                 stringWithFormat:@"Player %@'s Turn",
                                 [self.delegate currentPlayerString]];
    [self.delegate displayString:displayString
                  withColorOrNil:[self.delegate currentPlayerColor]];
}

- (void)setEndOfGame:(BOOL)endOfGame
{
    _endOfGame = endOfGame;
    [self.delegate setEndOfGame:endOfGame];
}

- (BOOL)checkIfSymbolPlayedAtRow:(NSInteger)row column:(NSInteger)column
{
    if ([self validityOfRow:row column:column] == YES) {
        return (![_dataArray[row][column] isEqual:@0]);
    } else {
        return YES;
    }
}

- (BOOL)validityOfRow:(int)row column:(int)column
{
    return ((row >= 0) && (row <= _rowCount) &&
            (column >= 0) && (column <= _columnCount));
}

- (void)playSymbol:(NSInteger)symbol atRow:(NSInteger)row column:(NSInteger)column
{
    
    if ([self endOfGame] == YES) {
        return;
    }
    
    [[[self dataArray] objectAtIndex:row] replaceObjectAtIndex:column withObject:@(symbol)];
    
    // Checking rows and columns for win
    for (int i = 0; i < _rowCount; i++) {
        
        // Rows
        NSMutableSet *rowSet = [[NSMutableSet alloc] init];
        for (int column = 0; column < _columnCount; column++) {
            [rowSet addObject:_dataArray[i][column]];
        }
        if ([rowSet count] == 1 && ![rowSet containsObject:@0]) {
            // Win
            NSString *winnerString = [NSString
                                      stringWithFormat:@"Player %@ Won!",
                                      [self.delegate currentPlayerString]];
                                      
            [self.delegate displayString:winnerString
                          withColorOrNil:[self.delegate currentPlayerColor]];
            [self.delegate drawLineFromRow0:i
                                 andColumn0:0
                                     toRow1:i
                                 andColumn1:_columnCount - 1];
            [self setEndOfGame:YES];
            return;
        }
    }
    
    for (int i = 0; i < _columnCount; i++) {
        // Columns
        NSMutableSet *colSet = [[NSMutableSet alloc] init];
        for (int row = 0; row < _rowCount; row++) {
            [colSet addObject:_dataArray[row][i]];
        }
        if ([colSet count] == 1 && ![colSet containsObject:@0]) {
            NSString *winnerString = [NSString
                                      stringWithFormat:@"Player %@ Won!",
                                      [self.delegate currentPlayerString]];
                                      
            [self.delegate displayString:winnerString
                          withColorOrNil:[self.delegate currentPlayerColor]];
            [self.delegate drawLineFromRow0:0
                                 andColumn0:i
                                     toRow1:_rowCount - 1
                                 andColumn1:i];
            [self setEndOfGame:YES];
            return;
        }
    }
    
    
    for (int i = 0; i <= abs(_rowCount - _columnCount); i++) {
        NSMutableSet *backSlashSet = [[NSMutableSet alloc] init];
        if (_columnCount >= _rowCount) {
            for (int j = 0; j < _rowCount; j++) {
                [backSlashSet addObject:_dataArray[j][i + j]];
            }
            if ([backSlashSet count] == 1 && ![backSlashSet containsObject:@0]) {
                NSString *winnerString = [NSString
                                          stringWithFormat:@"Player %@ Won!",
                                          [self.delegate currentPlayerString]];
                                          
                [self.delegate displayString:winnerString
                              withColorOrNil:[self.delegate currentPlayerColor]];
                [self.delegate drawLineFromRow0:0
                                     andColumn0:i
                                         toRow1:_rowCount - 1
                                     andColumn1:_rowCount - 1 + i];
                [self setEndOfGame:YES];
                return; //Win
            }
        } else {
            for (int j = 0; j < _columnCount; j++) {
                [backSlashSet addObject:_dataArray[i + j][j]];
            }
            if ([backSlashSet count] == 1 && ![backSlashSet containsObject:@0]) {
                NSString *winnerString = [NSString
                                          stringWithFormat:@"Player %@ Won!",
                                          [self.delegate currentPlayerString]];
                                          
                [self.delegate displayString:winnerString
                              withColorOrNil:[self.delegate currentPlayerColor]];
                [self.delegate drawLineFromRow0:i
                                     andColumn0:0
                                         toRow1:_columnCount - 1 + i
                                     andColumn1:_columnCount - 1];
                [self setEndOfGame:YES];
                return; //Win
            }
        }
    }
    
    for (int i = 0; i <= abs(_rowCount - _columnCount); i++) {
        NSMutableSet *forwardSlashSet = [[NSMutableSet alloc] init];
        if (_columnCount >= _rowCount) {
            for (int j = _rowCount - 1; j >= 0; j--) {
                [forwardSlashSet addObject:_dataArray[j][_rowCount - 1 - j + i]];
            }
            if ([forwardSlashSet count] == 1 && ![forwardSlashSet containsObject:@0]) {
                NSString *winnerString = [NSString
                                          stringWithFormat:@"Player %@ Won!",
                                          [self.delegate currentPlayerString]];
                                          
                [self.delegate displayString:winnerString
                              withColorOrNil:[self.delegate currentPlayerColor]];
                [self.delegate drawLineFromRow0:0
                                     andColumn0:_rowCount - 1 + i
                                         toRow1:_rowCount - 1
                                     andColumn1:i];
                [self setEndOfGame:YES];
                return; //Win
            }
        } else {
            for (int j = _columnCount - 1; j >= 0; j--) {
                [forwardSlashSet addObject:_dataArray[_columnCount - 1 - j + i][j]];
            }
            if ([forwardSlashSet count] == 1 && ![forwardSlashSet containsObject:@0]) {
                NSString *winnerString = [NSString
                                          stringWithFormat:@"Player %@ Won!",
                                          [self.delegate currentPlayerString]];
                                          
                [self.delegate displayString:winnerString
                              withColorOrNil:[self.delegate currentPlayerColor]];
                [self.delegate drawLineFromRow0:i
                                     andColumn0:_columnCount - 1
                                         toRow1:_columnCount - 1 + i
                                     andColumn1:0];
                [self setEndOfGame:YES];
                return; //Win
            }
        }
    }
    
    BOOL catsGame = YES; // YES by default, until check
    for (int i = 0; i < 3; i++) {
        if ([_dataArray[i] containsObject:@0]) {
            catsGame = NO;
        }
    }
    if (catsGame == YES) {
        [self.delegate displayString:@"Cat's Game :("
                      withColorOrNil:[UIColor blueColor]];
        [self setEndOfGame:YES];
        return;
    }
    
    // If no win
    [self changePlayers];
    NSString *displayString = [NSString
                                 stringWithFormat:@"Player %@'s Turn",
                                 [self.delegate currentPlayerString]];
    [self.delegate displayString:displayString
                  withColorOrNil:[self.delegate currentPlayerColor]];
    
}

- (void)changePlayers
{
    if (_currentPlayer == GamePlayer1) {
        _currentPlayer = GamePlayer2;
    } else if (_currentPlayer == GamePlayer2) {
        _currentPlayer = GamePlayer1;
    }
}

@end
