//
//  WalkingTimeRequest.h
//  StopcastPre
//
//  Created by Eric Allam on 13/02/2014.
//  Copyright (c) 2014 CS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ELAWalkingTime : NSObject

- (instancetype) initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)cancel;

- (void)getWalkingTimeInSeconds:(void (^)(NSUInteger, NSError *))completion;

@end
