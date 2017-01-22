//
//  CountdownViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface CountdownViewController : UIViewController  {
    int currentNumber;
    NSTimer *timer;
}


@property (strong, nonatomic) AppDelegate *appDelegate;
@property (nonatomic, strong) NSString *uuid;

@property (weak, nonatomic) IBOutlet UILabel *countdonLabel;

- (void)timeDown;
- (void)handleReceivedDataWithNotification:(NSNotification *)notification;
- (void)startGame;


@end
