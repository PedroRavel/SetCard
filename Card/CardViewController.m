//
//  CardViewController.m
//  Card
//
//  Created by Pete on 9/14/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "CardViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
@interface CardViewController ()





@property (strong, readwrite) NSMutableArray *getit;



//@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardViewController
-(CardMatchingGame *)game{
    if(!_game)_game = [[CardMatchingGame alloc] initWithCardCount:52 usingDeck:[self createDeck]];
    return _game;
}
-(NSMutableArray *)getit{
    if(!_getit)_getit = [[NSMutableArray alloc] init];
    return _getit;
}


//abstract method
-(Deck *) createDeck
{
   
    return nil;
}



-(void)updateUI{
  
}

-(NSString *)titleForCard:(Card *)card{
    return card.isChsoen ? card.contents : @"";
}
-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChsoen ? @"cardfront" : @"cardBack"];
}


@end
