//
//  ViewController.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "GameViewController.h"
#import "TBoardView.h"
#import "TGameDataModel.h"
#import "TLineOverlayView.h"

typedef NS_ENUM(NSUInteger, GamePlayer) {
    GamePlayerNone,
    GamePlayer1,
    GamePlayer2
};

@interface GameViewController ()

@property (strong, nonatomic) IBOutlet UITextView *gameDescription;
@property (strong, nonatomic) TGameDataModel *gameBoard;
@property (strong, nonatomic) TBoardView *boardView;

@property BOOL endOfGame;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TGameDataModel *gameB = [[TGameDataModel alloc] init];
    TBoardView *boardV = [[TBoardView alloc]
                          initWithFrame:CGRectMake(0, 0, 275, 275)];
    CGPoint boardViewCenter;
    boardViewCenter.x = self.view.center.x;
    boardViewCenter.y = self.view.center.y - 30;
    [boardV setCenter:boardViewCenter];
    
    [self setGameBoard:gameB];
    [self setBoardView:boardV];
    
    [_gameBoard setDelegate:self];
    [_boardView setDelegate:self];
    
    [self.view addSubview:_boardView];
}

- (IBAction)resetGame:(id)sender
{
    
    [_boardView reset];
    TGameDataModel *newGameB = [[TGameDataModel alloc] init];
    _gameBoard = newGameB;
    [_gameBoard setDelegate:self];
    _endOfGame = NO;
    
}

- (void)playSymbol:(NSString *)symbol atRow:(NSInteger)row column:(NSInteger)column
{
    int intSymbolAlias = ([symbol isEqualToString:@"X"]) ? 1 : 2;
    NSInteger symbolAlias = intSymbolAlias;
    [[self gameBoard] playSymbol:symbolAlias
                           atRow:row
                       column:column];
}

- (BOOL)checkIfSymbolPlayedAtRow:(NSInteger)row column:(NSInteger)column
{
    return [[self gameBoard] checkIfSymbolPlayedAtRow:row column:column];
}

- (void)displayString:(NSString *)string withColorOrNil:(UIColor *)color
{
    [[self gameDescription] setText:string];
    if (color) {
        [[self gameDescription] setTextColor:color];
    } else {
        [[self gameDescription] setTextColor:[UIColor blackColor]];
    }
    [[self gameDescription] setNeedsDisplay];
    
}

- (void)drawLineFromRow0:(NSInteger)row0 andColumn0:(NSInteger)column0 toRow1:(NSInteger)row1 andColumn1:(NSInteger)column1
{
    [[self boardView] drawLineFromRow0:row0 andColumn0:column0 toRow1:row1 andColumn1:column1];
}

- (UIColor *)currentPlayerColor
{
    if ([[self currentPlayerString] isEqualToString:@"X"]) {
        return [UIColor redColor];
    } else if ([[self currentPlayerString] isEqualToString:@"O"]) {
        return [UIColor colorWithRed:0
                               green:0.6
                                blue:0
                               alpha:1];
    } else {
        return [UIColor clearColor];
    }
}

- (NSString *)currentPlayerString
{
    if ([[self gameBoard] currentPlayer] == GamePlayer1) {
        return @"X";
    } else if ([[self gameBoard] currentPlayer] == GamePlayer2) {
        return @"O";
    } else {
        return @"";
    }
}

@end
