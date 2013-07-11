//
//  TBoardViewGestureRecognizer.m
//  TicTacToeYo
//
//  Created by Aleks Kamko on 7/10/13.
//  Copyright (c) 2013 Aleks Kamko. All rights reserved.
//

#import "TTouchAndPanGestureRecognizer.h"

@implementation TTouchAndPanGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.state = UIGestureRecognizerStateBegan;
    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    self.state = UIGestureRecognizerStateChanged;
    if (self.state == UIGestureRecognizerStateFailed) return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateEnded;
    if (self.state == UIGestureRecognizerStateFailed) return;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
}

- (void)reset {
    [super reset];
}

@end
