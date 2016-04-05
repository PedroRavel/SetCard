//
//  SetCardDeck.m
//  Card
//
//  Created by Pete on 10/11/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
- (instancetype)init
{
    self = [super init];
    
    if(self){
       // for(NSNumber *count in [SetCard validCount]){
        for (NSUInteger i=1; i<=3; i++) {
        for(NSString *shades in [SetCard validShades]){
        for(NSString *set in [SetCard validSets]) {
            for(UIColor * cols in [SetCard validColors]){

                    SetCard *card = [[SetCard alloc] init];
                //card.count = [count integerValue];
                card.count =  i;
  
         
                    card.symbol = set;
                    card.color = cols;

                    card.shade = shades;
           
                    [self addSetCard:card];
       
            }
            }
        }
        }
    }
    return self;
}

@end
