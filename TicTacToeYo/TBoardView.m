//
//  TBoardView.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TBoardView.h"
#import "TCellView.h"
#import "TLineOverlayView.h"
#import "TTouchAndPanGestureRecognizer.h"

@interface TBoardView () <UIGestureRecognizerDelegate>
{
    CGRect _currentCellFrame;
    int _currentCellRow;
    int _currentCellColumn;
}

@property int rowCount;
@property int columnCount;
@property NSMutableArray *cellArray;

- (void)currentlyTouchedCellIsAtRow:(int)row andColumn:(int)column;

@end

@implementation TBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame andWithNumberOfRows:3 columns:3];
    return self;
}

- (id)initWithFrame:(CGRect)frame andWithNumberOfRows:(NSInteger)rows columns:(NSInteger)columns
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        
        // Child cell stuff
        _rowCount = rows;
        _columnCount = columns;
        _cellArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < rows; j++) {
            NSMutableArray *cellSubArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < columns; i++) {
                CGRect cellRect = CGRectMake((frame.size.width - 3)/columns * i + 3,
                                             (frame.size.height - 3)/rows * j + 3,
                                             (frame.size.width - 3)/columns - 3,
                                             (frame.size.height - 3)/rows - 3);
                TCellView *cell = [[TCellView alloc] initWithFrame: cellRect];
                [cellSubArray addObject:cell];
                [self addSubview:cell];
            }
            [_cellArray addObject:cellSubArray];
        }
        
        // Touch stuff
        self.multipleTouchEnabled = NO;
        self.userInteractionEnabled = YES;
        UIGestureRecognizer *gestureRecognizer = [[TTouchAndPanGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleTouchInput:)];
        [self addGestureRecognizer:gestureRecognizer];
        _currentCellFrame = CGRectMake(-100, -100, 0, 0);
        [self currentlyTouchedCellIsAtRow:-1 andColumn:-1];
        
    }
    return self;
}

- (void)handleTouchInput:(UIPanGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate endOfGame] == YES) {
        return;
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self];
    NSString *symbol = [self.delegate currentPlayerString];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self setSymbol:symbol atCellContainingPoint:touchPoint];
    }
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (!(CGRectContainsPoint(_currentCellFrame, touchPoint))) {
            [self clearCurrentCell];
            [self setSymbol:symbol atCellContainingPoint:touchPoint];
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([self checkIfAnyCellContainsPoint:touchPoint] &&
            ([self.delegate checkIfSymbolPlayedAtRow:_currentCellRow column:_currentCellColumn] == NO)) {
            [self.delegate playSymbol:[self.delegate currentPlayerString]
                                atRow:_currentCellRow
                               column:_currentCellColumn];
        }
        
        _currentCellFrame = CGRectMake(-100, -100, 0, 0);
        [self currentlyTouchedCellIsAtRow:-1 andColumn:-1];
    }
}

- (BOOL)checkIfAnyCellContainsPoint:(CGPoint)point
{
    for (int row = 0; row < _rowCount; row++) {
        for (int column = 0; column < _columnCount; column++) {
            TCellView *cell = [self cellArray][row][column];
            CGRect cellFrame = cell.frame;
            if (CGRectContainsPoint(cellFrame, point)) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)setSymbol:(NSString *)symbol atCellContainingPoint:(CGPoint)point
{
    if (!(CGRectContainsPoint(_currentCellFrame, point))) {
        for (int i = 0; i < _rowCount; i++) {
            for (int j = 0; j < _columnCount; j++) {
                TCellView *cell = [self cellArray][i][j];
                CGRect cellFrame = cell.frame;
                if (CGRectContainsPoint(cellFrame, point)) {
                    [self currentlyTouchedCellIsAtRow:i andColumn:j];
                    _currentCellFrame = cellFrame;
                    if ([self.delegate checkIfSymbolPlayedAtRow:i column:j]
                        == NO) {
                        [self displayCellSymbol:symbol atRow:i column:j];
                    }
                    return;
                }
            }
        }
    }
}

- (void)clearCurrentCell
{
    if ([self.delegate checkIfSymbolPlayedAtRow:_currentCellRow
                                         column:_currentCellColumn] == NO) {
        [self displayCellSymbol:nil
                        atRow:_currentCellRow
                    column:_currentCellColumn];
    }
}


- (void)displayCellSymbol:(NSString *)symbol atRow:(NSInteger)row column:(NSInteger)column
{
    TCellView *cell = [self cellArray][row][column];
    [cell setSymbol:symbol];
}

- (void)drawLineFromRow0:(NSInteger)row0 andColumn0:(NSInteger)column0 toRow1:(NSInteger)row1 andColumn1:(NSInteger)column1;
{
    CGRect lineViewFrame = CGRectMake(0, 0,
                                       self.frame.size.width,
                                       self.frame.size.height);
    TLineOverlayView *lineView = [[TLineOverlayView alloc] initWithFrame:lineViewFrame];
    
    CGPoint startPoint = ((TCellView *) _cellArray[row0][column0]).center;
    CGPoint endPoint = ((TCellView *) _cellArray[row1][column1]).center;
    [lineView setStartPoint:startPoint];
    [lineView setEndPoint:endPoint];
    
    [self addSubview:lineView];
}

- (void)currentlyTouchedCellIsAtRow:(int)row andColumn:(int)column
{
    _currentCellRow = row;
    _currentCellColumn = column;
}


- (void)reset
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    (void) [self initWithFrame:[self frame]];
}

@end
