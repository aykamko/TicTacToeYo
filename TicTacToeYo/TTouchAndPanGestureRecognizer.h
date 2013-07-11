//
//  TBoardViewGestureRecognizer.h
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/10/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface TTouchAndPanGestureRecognizer : UIGestureRecognizer

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
