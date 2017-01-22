//
//  PlayerSetupViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"

@interface PlayerSetupViewController : UIViewController {
    NSMutableArray *labelArray;
    int peersConnected;
}

@property (strong, nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UILabel *playerLabel1;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel2;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel3;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel4;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel6;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel7;
@property (strong, nonatomic) NSUUID *uuid;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel5;

- (void)peerChangedStateWithNotification:(NSNotification *)notification;
- (void)handleReceivedDataWithNotification:(NSNotification *)notification;


@end
