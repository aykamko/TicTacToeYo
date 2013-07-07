//
//  TGameArray.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TGameArray.h"
#import "TBoard.h"

@implementation TGameArray

- (instancetype)initForNewBoard:(TBoard *)pb
{
    self = [super init];
    [self setParentBoard:pb];
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        [_dataArray addObject:@0];
    }
    return self;
}

- (void)setObject:(id)obj toIndex:(NSUInteger)idx
{
    [_dataArray setObject:obj atIndexedSubscript:idx];
    
    if (![[self dataArray] containsObject:@0]) {
        [[self parentBoard] displayTieString];
    }
    
    for (int i = 0; i < 3; i++) {
        NSMutableSet *colSet = [[NSMutableSet alloc] init];
        NSMutableSet *rowSet = [[NSMutableSet alloc] init];
        // Checking column for win
        [colSet addObject:_dataArray[i + 0]];
        [colSet addObject:_dataArray[i + 3]];
        [colSet addObject:_dataArray[i + 6]];
        // Checking row for win
        [rowSet addObject:_dataArray[0 + (i * 3)]];
        [rowSet addObject:_dataArray[1 + (i * 3)]];
        [rowSet addObject:_dataArray[2 + (i * 3)]];
        
        if (([rowSet count] == 1 && ![rowSet containsObject:@0]) ||
            ([colSet count] == 1 && ![colSet containsObject:@0])) {
            [[self parentBoard] displayWinnerString];
        }
    }
    
    // Checking two diagonals for winning condition
    NSMutableSet *diagSet = [[NSMutableSet alloc] init];
    [diagSet addObject:_dataArray[0]];
    [diagSet addObject:_dataArray[4]];
    [diagSet addObject:_dataArray[8]];
    if ([diagSet count] == 1 && ![diagSet containsObject:@0]) {
        [[self parentBoard] displayWinnerString];
        //Win
    }
    
    [diagSet removeAllObjects];
    [diagSet addObject:_dataArray[2]];
    [diagSet addObject:_dataArray[4]];
    [diagSet addObject:_dataArray[6]];
    if ([diagSet count] == 1 && ![diagSet containsObject:@0]) {
        [[self parentBoard] displayWinnerString];
        //Win
    }
    
    if ([[self parentBoard] end] == NO) {
        [[self parentBoard] displayPlayerString];
    }
    
}

@end
