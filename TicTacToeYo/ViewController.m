//
//  ViewController.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "ViewController.h"
#import "TBoard.h"
#import "TGameArray.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [self setGameBoard:[[TBoard alloc] initWithFrame:CGRectMake(0, 0, 275, 275)
                                      andDescription:[self gameDescription]]];
    [_gameBoard setCenter:CGPointMake(screenRect.size.width/2,
                                screenRect.size.height/2 - 25)];
    
    [self.view addSubview:_gameBoard];
                              
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetGame:(id)sender {
    
    [[self gameBoard] resetGame];

}
@end
