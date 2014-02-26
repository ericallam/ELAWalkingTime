//
//  ELAWalkingTime.m
//
//  Created by Eric Allam on 13/02/2014.
#import "ELAWalkingTime.h"
#import <MapKit/MapKit.h>

@interface ELAWalkingTime ()
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) MKDirections *directionsRequest;
@end

@implementation ELAWalkingTime

- (instancetype) initWithCoordinate:(CLLocationCoordinate2D)coordinate;
{
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    
    return self;
}

- (void)cancel
{
    [self.directionsRequest cancel];
}

- (void)getWalkingTimeInSeconds:(void (^)(NSUInteger, NSError *))completion
{
    MKDirectionsRequest *request = [MKDirectionsRequest new];
    request.transportType = MKDirectionsTransportTypeWalking;
    request.source = [self mapItemForCurrentLocation];
    request.departureDate = [NSDate date];
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:@{}];
    request.destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    if (self.directionsRequest && self.directionsRequest.calculating) {
        [self.directionsRequest cancel];
    }
    
    self.directionsRequest = [[MKDirections alloc] initWithRequest:request];
    
    [self.directionsRequest calculateETAWithCompletionHandler:^(MKETAResponse *response, NSError *error) {
        
        if (error) {            
            completion(0, error);
        }else{
            completion(response.expectedTravelTime, nil);
        }
    }];
}

- (MKMapItem *)mapItemForCurrentLocation
{
    return [MKMapItem mapItemForCurrentLocation];
}

@end
