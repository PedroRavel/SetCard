//
//  SetCard.h
//  Card
//
//  Created by Pete on 10/11/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetCard : NSObject
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *contents;

@property (nonatomic) NSUInteger count;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic) NSString *shade;
@property (nonatomic, getter = isChsoen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
- (NSAttributedString *)getSetContents;
+ (NSArray *)validSets;
+ (NSArray *)validCount;
- (BOOL)match:(SetCard *)card1 Card2:(SetCard *)card2;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
- (int)match:(NSArray *)otherCards;

@end
