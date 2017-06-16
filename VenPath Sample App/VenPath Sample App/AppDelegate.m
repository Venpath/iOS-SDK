//
//  AppDelegate.m
//  VenPath Sample App
//
//  Copyright © 2017 VenPath. All rights reserved.
//

#import "AppDelegate.h"
#import "VenPath.h"

@import CoreLocation;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    VenPath *venpath = [VenPath shared];
    [venpath sdkKey:@"SDK KEY HERE" publicKey:@"TOKEN HERE" secretKey:@"SECRET HERE" ];
    
//    venpath.debug = YES;
    venpath.connectionErrorHandler = ^void (NSString *error) {
        NSLog(@"%@",error);
    };
    self.venpath = venpath;
    [self turnOnLocationTracking];
    
    return YES;
    
    
    
    return YES;
}

- (void) turnOnLocationTracking
{
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied){
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.pausesLocationUpdatesAutomatically = false;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//          This is for requesting location in the foreground and background.  Be sure to turn on the app's capabilities for Background Services -> Location
            [self.locationManager requestAlwaysAuthorization];
//          This is for requesting foreground location only
//          [self.locationManager requestWhenInUseAuthorization];
            
            [self.locationManager startUpdatingLocation];
        }
    }
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    [self.venpath trackLocation:location];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void) locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    
}

- (void)sendEmailToVenPath:(NSString*)email
{
    [self.venpath track:@{
                          @"email":@"newemail@test.com",
                          @"new_user": @"true"
                          }];
    
}

- (void)sendAppUsageToVenPath:(NSString*)email
{
        NSNumber* timestamp = [NSNumber numberWithLongLong:(long long)([[NSDate date] timeIntervalSince1970])];
    
        [self.venpath track:@{
                                 @"app_name": @"Test App",
                                 @"event_date": timestamp,
                                 @"event_type": @"launch",
                                 @"seconds_used": @"100",
                                 @"permissions": @"comma,delimited,list"
                                 }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //This allows the app to wake up from a background state when the location of the device has changed
    [self.locationManager startMonitoringSignificantLocationChanges];
}


@end
