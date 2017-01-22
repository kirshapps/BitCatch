//
//  MainPlayerGameViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MainPlayerGameViewController : UIViewController <CLLocationManagerDelegate> {
    int dif;
    CLProximity proximity;
    CLBeacon *beaconFound;
    CLLocationAccuracy accuracy;
    CLLocationAccuracy prevAccuracy;
    BOOL warmer;
    int countdown;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIButton *playSoundButton;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSUUID *uuid;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)playSoundButton:(id)sender;
- (void)getBeacons;
- (void)gotUUID:(NSNotification *)notification;
- (void)countdown;

@end
