//
//  RKArticle.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKArticle : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSArray * tags;
@property (nonatomic, strong) NSDate * createdAt;

@end