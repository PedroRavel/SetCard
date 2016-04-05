//
//  Card.h
//  Card
//
//  Created by Pete on 9/14/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (strong, nonatomic) NSString *set;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) float shade;
@property (nonatomic) NSUInteger count;
@property (nonatomic, getter = isChsoen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;





- (int)match:(NSArray *)otherCards;

@end
