//
//  CardMatchingGame.h
//  Card
//
//  Created by Pete on 9/24/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "SetDeck.h"
#import "SetCard.h"
@interface CardMatchingGame : NSObject
  //designated initializer 
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
-(instancetype)initWithSetCardCount:(NSUInteger)count usingDeck:(SetDeck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(void)chooseSetCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(SetCard *)setCardAtIndex:(NSUInteger)index;
-(void) gameTwo;
-(NSMutableArray*)cheater;
-(void)restartSet;
-(NSArray *)currentSetDeck;
-(void) gameThree;
-(NSMutableArray*)getIt;
-(NSMutableArray*)removeMatched;
- (NSUInteger)deckCards;
-(void)theRemoval:(NSMutableIndexSet *)set;
-(void)deductCheat;
-(void)lastOne;
-(void)removeEm:(NSMutableIndexSet *)nums;
-(void)addThreeCards:(NSUInteger*)n;
- (NSIndexSet *)getMatches:(NSArray *)cards;
-(NSString *)gimme:(NSUInteger)i;
-(NSArray *)currentPlayingDeck;
@property(nonatomic,strong)NSMutableAttributedString *cardType;
@property(nonatomic,strong)NSMutableArray *history;


@property (nonatomic,readonly) NSInteger score;
@property (nonatomic,readonly) NSInteger number;
@property (nonatomic,readonly) BOOL store;

@end
