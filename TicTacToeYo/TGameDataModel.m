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

@property (nonatomic) BOOL endOfGame;
@property NSMutableArray *dataArray;

- (void)changePlayers;

@end

@implementation TGameDataModel

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        
        // Initializing empty array
        _dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            [_dataArray addObject:[[NSMutableArray alloc]
                                   initWithObjects:@0, @0, @0, nil]];
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
    if ((row > -1) && (row < 3) && (column > -1) && (row < 3)) {
        return (![_dataArray[row][column] isEqual:@0]);
    } else {
        return YES;
    }
}

- (void)playSymbol:(NSInteger)symbol atRow:(NSInteger)row column:(NSInteger)column
{
    
    if ([self endOfGame] == YES) {
        return;
    }
    
    [[[self dataArray] objectAtIndex:row] replaceObjectAtIndex:column withObject:@(symbol)];
    
    for (int i = 0; i < 3; i++) {
        NSMutableSet *rowSet = [[NSMutableSet alloc] init];
        
        // Checking row for win
        [rowSet addObject:_dataArray[i][0]];
        [rowSet addObject:_dataArray[i][1]];
        [rowSet addObject:_dataArray[i][2]];
        
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
                                 andColumn1:2];
            [self setEndOfGame:YES];
            return;
        }
        
        NSMutableSet *colSet = [[NSMutableSet alloc] init];
        
        // Checking column for win
        [colSet addObject:_dataArray[0][i]];
        [colSet addObject:_dataArray[1][i]];
        [colSet addObject:_dataArray[2][i]];
        
        if ([colSet count] == 1 && ![colSet containsObject:@0]) {
            NSString *winnerString = [NSString
                                      stringWithFormat:@"Player %@ Won!",
                                      [self.delegate currentPlayerString]];
                                      
            [self.delegate displayString:winnerString
                          withColorOrNil:[self.delegate currentPlayerColor]];
            [self.delegate drawLineFromRow0:0
                                 andColumn0:i
                                     toRow1:2
                                 andColumn1:i];
            [self setEndOfGame:YES];
            return;
        }
    }
    
    // Checking two diagonals for win
    NSMutableSet *diagSet = [[NSMutableSet alloc] init];
    [diagSet addObject:_dataArray[0][0]];
    [diagSet addObject:_dataArray[1][1]];
    [diagSet addObject:_dataArray[2][2]];
    if ([diagSet count] == 1 && ![diagSet containsObject:@0]) {
        NSString *winnerString = [NSString
                                  stringWithFormat:@"Player %@ Won!",
                                  [self.delegate currentPlayerString]];
                                  
        [self.delegate displayString:winnerString
                      withColorOrNil:[self.delegate currentPlayerColor]];
        [self.delegate drawLineFromRow0:0
                             andColumn0:0
                                 toRow1:2
                             andColumn1:2];
        [self setEndOfGame:YES];
        return; //Win
    }
    
    [diagSet removeAllObjects];
    [diagSet addObject:_dataArray[0][2]];
    [diagSet addObject:_dataArray[1][1]];
    [diagSet addObject:_dataArray[2][0]];
    if ([diagSet count] == 1 && ![diagSet containsObject:@0]) {
        NSString *winnerString = [NSString
                                  stringWithFormat:@"Player %@ Won!",
                                  [self.delegate currentPlayerString]];
                                  
        [self.delegate displayString:winnerString
                      withColorOrNil:[self.delegate currentPlayerColor]];
        [self.delegate drawLineFromRow0:0
                             andColumn0:2
                                 toRow1:2
                             andColumn1:0];
        [self setEndOfGame:YES];
        return; //Win
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
