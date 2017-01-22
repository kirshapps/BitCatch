//
//  ViewController.m
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#define METERS_PER_MILE 1000.344

@implementation ViewController

@synthesize locationManager, currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc]init];
    //[locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    _createGameButton.alpha = 0;
    _createGameButton.layer.cornerRadius = 20;
    _startButton.layer.cornerRadius = 20;
    _hasCreatedGame = NO;
    _waitForInviteLabel.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    currentLocation = newLocation;
}

- (void)fadeOut:(UIButton *)object {
     object.alpha = 1;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    object.alpha = 0;
    [UIView commitAnimations];
}

- (void)fadeIn:(UIButton *)button {
    button.alpha = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    button.alpha = 1;
    [UIView commitAnimations];
}







- (IBAction)createGame:(id)sender {
    if (self.appDelegate.mpcHandler.session != nil) {
        [[self.appDelegate mpcHandler] setupBrowser];
        [[[self.appDelegate mpcHandler] browser] setDelegate:self];
        _hasCreatedGame = YES;
        [self presentViewController:self.appDelegate.mpcHandler.browser
                           animated:YES
                         completion:nil];
        
    }
}





- (IBAction)startButtonClicked:(id)sender {
    [self fadeOut:_startButton];
    [self fadeIn:_createGameButton];
    CLLocationCoordinate2D coord;
    coord.latitude = currentLocation.coordinate.latitude;
    NSLog(@"%f", coord.latitude);
    coord.longitude = currentLocation.coordinate.longitude;
    NSLog(@"%f", coord.longitude);
    MKCoordinateRegion reg = MKCoordinateRegionMakeWithDistance(coord, METERS_PER_MILE*.5, METERS_PER_MILE*.5);
    
    [_mapView setRegion:reg animated:YES];
    [_mapView showsUserLocation];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [self.appDelegate.mpcHandler setupPeerWithDisplayName:[userDefaults stringForKey:@"email"]];
    [self.appDelegate.mpcHandler setupSession];
    [self.appDelegate.mpcHandler advertiseSelf:YES];
    [self.appDelegate.mpcHandler.advertiser setDelegate:self];
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [self.appDelegate.mpcHandler.browser dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Heading to view controller");
    if (_hasCreatedGame) {
    [self hostView];
    }
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [self.appDelegate.mpcHandler.browser dismissViewControllerAnimated:YES completion:nil];
    _hasCreatedGame = NO;
}

- (void)advertiserAssistantDidDismissInvitation:(MCAdvertiserAssistant *)advertiserAssistant {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"By playing this match, you have the potential to lose $0.10 worth of bitcoin. Make sure this is an amount you are willing to lose." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"I Understand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"playerBegin" sender:self];
    }];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)hostView {
    [self performSegueWithIdentifier:@"hostBegin" sender:self];
}




@end
