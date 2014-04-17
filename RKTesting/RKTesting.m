//
//  RKTesting.m
//  RKTesting
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>
#import "RKArticle.h"

@interface RKTesting : XCTestCase

@end

@implementation RKTesting

- (void)setUp
{
    [super setUp];
    // Configure RKTestFixture
    NSBundle *testTargetBundle = [NSBundle bundleWithIdentifier:@"org.restkit.RKTesting"];
    [RKTestFixture setFixtureBundle:testTargetBundle];
}
- (RKObjectMapping *)articleMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKArticle class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"article.title":   @"title",
                                                  @"article.author":  @"author",
                                                  @"article.tags":    @"tags"
                                                  }];
    return mapping;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:@"article.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:[self articleMapping] sourceObject:parsedJSON destinationObject:nil];
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"article.title" destinationKeyPath:@"title"]];
    //STAssertTrue([test evaluate], @"The title has not been set up!");
    // or
   // STAssertNoThrow([test verify], @"The title has not been set up!");
}
@end
