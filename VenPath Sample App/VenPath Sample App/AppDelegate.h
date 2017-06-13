//
//  AppDelegate.h
//  VenPath Sample App
//
//  Copyright © 2017 VenPath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VenPath.h"
@import CoreLocation;

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) VenPath *venpath;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

