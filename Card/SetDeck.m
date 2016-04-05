//
//  SetDeck.m
//  Card
//
//  Created by Pete on 10/11/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "SetDeck.h"

@interface SetDeck()
@property (strong, nonatomic)  NSMutableArray *cards;
@end



@implementation SetDeck


- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addSetCard:(SetCard *)card atTop:(BOOL)atTop
{
    if(atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}


- (void)addSetCard:(SetCard *)card
{
    [self addSetCard:card atTop:NO];
}




- (SetCard *)drawSetRandomCard
{
    SetCard *randomCard = nil;
    
    if([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
