//
//  ELAWalkingTimeTests.m
//  ELAWalkingTimeTests
//
//  Created by Eric Allam on 25/02/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import <ELAWalkingTime/ELAWalkingTime.h>
#import <MapKit/MapKit.h>

#import "AsyncMacros.h"

@interface ELAWalkingItemWithMockedCurrentLocation : ELAWalkingTime
@property (assign, nonatomic) CLLocationCoordinate2D mockedCurrentLocation;
@end

@implementation ELAWalkingItemWithMockedCurrentLocation
- (MKMapItem *)mapItemForCurrentLocation
{
    MKPlacemark *itemPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.mockedCurrentLocation addressDictionary:@{}];
    return [[MKMapItem alloc] initWithPlacemark:itemPlacemark];
}
@end

@interface ELAWalkingTimeTests : XCTestCase

@end

@implementation ELAWalkingTimeTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetWalkingTimeInSeconds
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(51.567052, -0.080256);
    
    ELAWalkingItemWithMockedCurrentLocation *request = [[ELAWalkingItemWithMockedCurrentLocation alloc] initWithCoordinate:coordinate];
    
    request.mockedCurrentLocation = CLLocationCoordinate2DMake(51.564784, -0.073036); // About 5 minutes away
    
    StartBlock();
    
    __block NSUInteger result = 0;
    
    [request getWalkingTimeInSeconds:^(NSUInteger walkingTime, NSError *error) {
        result = walkingTime;
        EndBlock();
    }];

    WaitUntilBlockCompletes();
    
    XCTAssertTrue(result != 0);
    XCTAssertEqualWithAccuracy(result, 467, 50);
}

- (void)testCancelingARequest
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(51.567052, -0.080256);
    
    ELAWalkingItemWithMockedCurrentLocation *request = [[ELAWalkingItemWithMockedCurrentLocation alloc] initWithCoordinate:coordinate];
    
    request.mockedCurrentLocation = CLLocationCoordinate2DMake(51.564784, -0.073036);
    
    __block BOOL blockCalled = NO;
    
    [request getWalkingTimeInSeconds:^(NSUInteger walkingTime, NSError *error) {
        blockCalled = YES;
    }];
    
    [request cancel];
    
    XCTAssertFalse(blockCalled);
}

- (void)testResumingRequest
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(51.567052, -0.080256);
    
    ELAWalkingItemWithMockedCurrentLocation *request = [[ELAWalkingItemWithMockedCurrentLocation alloc] initWithCoordinate:coordinate];
    
    request.mockedCurrentLocation = CLLocationCoordinate2DMake(51.564784, -0.073036);
    
    [request getWalkingTimeInSeconds:^(NSUInteger walkingTime, NSError *error) {
    }];
    
    StartBlock();
    
    __block NSUInteger result = 0;

    [request getWalkingTimeInSeconds:^(NSUInteger walkingTime, NSError *error) {
        result = walkingTime;
        
        EndBlock();
    }];
    
    WaitUntilBlockCompletes();
    
    XCTAssertTrue(result != 0);
    XCTAssertEqualWithAccuracy(result, 467, 50);
}

@end
