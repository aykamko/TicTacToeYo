//
//  ViewController.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBoard.h"

@interface ViewController : UIViewController

- (IBAction)resetGame:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *gameDescription;
@property TBoard *gameBoard;

@end
