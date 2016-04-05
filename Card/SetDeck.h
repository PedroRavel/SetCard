//
//  SetDeck.h
//  Card
//
//  Created by Pete on 10/11/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCard.h"
@interface SetDeck : NSObject
- (void)addSetCard:(SetCard *)card atTop:(BOOL)atTop;
- (void)addSetCard:(SetCard *)card;

- (SetCard *)drawSetRandomCard;
@end
