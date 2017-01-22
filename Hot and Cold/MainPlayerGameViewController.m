//
//  MainPlayerGameViewController.m
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import "MainPlayerGameViewController.h"

@interface MainPlayerGameViewController ()

@end

@implementation MainPlayerGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    countdown = 45;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.uuid = [[NSUUID alloc]initWithUUIDString:[prefs objectForKey:@"uuid"]];
    
    NSLog(@"UUID on MainPlayerGame: %@", self.uuid);
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    self.myBeaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:self.uuid identifier:@"com.kirshapps.warmerandcolder"];
    
    //[self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(getBeacons) userInfo:nil repeats:YES];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.myBeaconRegion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"You are in the region");
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    NSLog(@"You left the region");
}

- (void)countdown {
    if (countdown > 0) {
        countdown = countdown - 1;
        _countdownLabel.text = [NSString stringWithFormat:@"%i", countdown];
    }
    else {
        NSString *string = @"won";
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        [_locationManager stopRangingBeaconsInRegion:_myBeaconRegion];
        [self.appDelegate.mpcHandler.session sendData:data toPeers:self.appDelegate.mpcHandler.session.connectedPeers withMode:MCSessionSendDataReliable error:&error];
        [self performSegueWithIdentifier:@"lostGame" sender:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Did range beacons called");
    beaconFound = [beacons firstObject];
    proximity = beaconFound.proximity;
    accuracy = beaconFound.accuracy;
    
    NSString *distanceString;
    
    if (proximity == CLProximityImmediate) {
        NSLog(@"Game Over");
        NSString *string = @"lost";
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        [_locationManager stopRangingBeaconsInRegion:_myBeaconRegion];
         [self.appDelegate.mpcHandler.session sendData:data toPeers:self.appDelegate.mpcHandler.session.connectedPeers withMode:MCSessionSendDataReliable error:&error];
        [self performSegueWithIdentifier:@"gameOver" sender:self];
    }
    else {
        if (accuracy < prevAccuracy) {
            _imageView1.image = [UIImage imageNamed:@"Fire_Emoji_grande.png"];
            _imageView2.image = [UIImage imageNamed:@"Fire_Emoji_grande.png"];
            _imageView3.image = [UIImage imageNamed:@"Fire_Emoji_grande.png"];
        }
        else {
            _imageView1.image = [UIImage imageNamed:@"Emoji_Snowflake_Download.png"];
            _imageView2.image = [UIImage imageNamed:@"Emoji_Snowflake_Download.png"];
            _imageView3.image = [UIImage imageNamed:@"Emoji_Snowflake_Download.png"];
        }
    }
    
    NSLog(@"Standard: %f", accuracy);
    
    
    prevAccuracy = accuracy;
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
   NSLog(@"started monitoring");
   [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

+(NSNumber *)absoluteValue:(NSNumber *)input {
    return [NSNumber numberWithDouble:fabs([input doubleValue])];
}

// The following method is no longer needed due to the constant updating of the didRangeBeacons: method

/* -void)getBeacons {
    NSLog(@"X");
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    NSLog(@"XX");
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    
    rssid = beaconFound.rssi;
    proximity = beaconFound.proximity;
    
    NSLog(@"%d", proximity);
    NSLog(@"%i", rssid);
    
} */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playSoundButton:(id)sender {
    NSString *string = @"host play sound";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    [_appDelegate.mpcHandler.session sendData:data toPeers:_appDelegate.mpcHandler.session.connectedPeers withMode:MCSessionSendDataReliable error:&error];
}

@end
