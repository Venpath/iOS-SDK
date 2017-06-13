#import <Foundation/Foundation.h>
@import CoreLocation;

@interface VenPath : NSObject <CLLocationManagerDelegate>

+(VenPath*)shared;
@property BOOL debug;
@property (strong) NSString* authSdkKey;
@property (strong) NSString* kAccess;
@property (strong) NSString* kSecret;
@property long long lastTracked;
@property long long lastBatchSent;
@property int lastSentGeneric;
@property (strong) NSString* ip;
@property (nonatomic, copy) void (^connectionErrorHandler)(NSString* error);

FOUNDATION_EXPORT NSString *const locationStream;
FOUNDATION_EXPORT NSString *const genericStream;
FOUNDATION_EXPORT NSString *const testStream;

- (void) auth: (NSString*)sdkKey token:(NSString*)token secret:(NSString*)secret;
- (void) trackLocation: (CLLocation*)location;
- (void) track: (NSDictionary*)data;
@end

