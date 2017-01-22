//
//  ViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "HostSetupViewController.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, MCBrowserViewControllerDelegate, MCAdvertiserAssistantDelegate> {
    BOOL isConnected;
}

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) HostSetupViewController *hostSetup;


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UIButton *createGameButton;
@property (nonatomic) BOOL hasCreatedGame;
@property (weak, nonatomic) IBOutlet UILabel *waitForInviteLabel;


- (void)foundLocation:(CLLocation *)location;
- (void)animateMapView:(CLLocationCoordinate2D)location;
- (IBAction)startButtonClicked:(id)sender;
- (void)fadeOut:(UIButton *)object;
- (void)fadeIn:(UIButton *)button;
- (void)peerChangedStateWithNotification:(NSNotification *)notification;
- (void)hostView;

- (IBAction)createGame:(id)sender;



@end

