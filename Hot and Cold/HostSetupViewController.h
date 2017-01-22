//
//  HostSetupViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface HostSetupViewController : UIViewController <CBPeripheralManagerDelegate> {
    int peersJoined;
    NSMutableArray *labelArray;
}

@property (strong, nonatomic) AppDelegate *appDelegate;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) NSDictionary *myBeaconData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (weak, nonatomic) IBOutlet UIButton *startGame;

@property (weak, nonatomic) IBOutlet UILabel *userAdd1;
@property (weak, nonatomic) IBOutlet UILabel *userAdd2;
@property (weak, nonatomic) IBOutlet UILabel *userAdd3;
@property (weak, nonatomic) IBOutlet UILabel *userAdd4;
@property (weak, nonatomic) IBOutlet UILabel *userAdd5;
@property (weak, nonatomic) IBOutlet UILabel *userAdd6;
@property (weak, nonatomic) IBOutlet UILabel *userAdd7;

- (void)peerChangedStateWithNotification:(NSNotification *)notification;
- (void)peerReceivedDataWithNotification:(NSNotification *)notification;
- (IBAction)startGame:(id)sender;
- (void)setupBeacon;



@end
