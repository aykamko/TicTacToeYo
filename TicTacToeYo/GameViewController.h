//
//  ViewController.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/5/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBoardView.h"
#import "TGameDataModel.h"

@interface GameViewController : UIViewController <TBoardViewDelegate, TGameDataModelDelegate>

@end