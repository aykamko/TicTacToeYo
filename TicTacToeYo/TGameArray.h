//
//  TGameArray.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TBoard;

@interface TGameArray : NSObject

@property (strong) TBoard *parentBoard;
@property NSMutableArray *dataArray;

- (instancetype)initForNewBoard:(TBoard *)pb;
- (void)setObject:(id)obj toIndex:(NSUInteger)idx;

@end
