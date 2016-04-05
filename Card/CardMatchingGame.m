//
//  CardMatchingGame.m
//  Card
//
//  Created by Pete on 9/24/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; //of Card
@property (nonatomic,strong) NSMutableArray *setCards; //of Card
@property (nonatomic,readwrite) NSInteger number;
@property (strong, nonatomic) SetDeck *deck;
@property (nonatomic, readwrite) BOOL store;


@end

@implementation CardMatchingGame

-(NSInteger)number{
    
    return _number;
}
-(BOOL)store{
    return _store;
}
-(NSMutableArray*)cheater{
    NSMutableArray * cheats = [[NSMutableArray alloc]init];
    for(int i = 0;i<[self.setCards count]; i++){
        for(int j = i+1; j <[self.setCards count]; j++){
            for(int k = j+1; k<[self.setCards count];k++){
                SetCard * q = self.setCards[i];
                SetCard* w = self.setCards[j];
                SetCard * e = self.setCards[k];
                //SetCard * r = (SetCard*)copy[i];
                //SetCard * t = (SetCard*)copy[j];
                //SetCard * y = (SetCard*)copy[k];
                if([q match:w Card2:e]){
                    [cheats addObject:q];
                    [cheats addObject:w];
                    [cheats addObject:e];
                    
                    return cheats;
                    
                }
            }
        }
    }
    return nil;
    
}
-(void)deductCheat{
    self.score -= 5;
}
-(NSArray *)currentSetDeck
{
    NSMutableArray *cards =[[NSMutableArray alloc] init];
    for (SetCard *card in self.setCards) {
        if (!card.isMatched) {
            [cards addObject:card];
        }
    }
    return cards;
}
-(NSArray *)currentPlayingDeck
{
    NSMutableArray *cards =[[NSMutableArray alloc] init];
    for (Card *card in self.cards) {

            [cards addObject:card];
        
    }
    return cards;
}
-(NSMutableArray *)history{
    if(!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
-(NSMutableArray *)setCards{
    if(!_setCards) _setCards = [[NSMutableArray alloc] init];
    return _setCards;
}
-(void)gameThree{
    self.number = 2;
}
-(void)gameTwo{
    self.number = 1;
}
-(NSMutableArray*)getIt{
    return self.setCards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init];   //supers designated initializer
    self.number = 1;
    if(self) {
        for(int i = 0; i<count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
            [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
    
}
-(instancetype)initWithSetCardCount:(NSUInteger)count usingDeck:(SetDeck *)deck{
    
    self = [super init];   //supers designated initializer
    self.number = 1;
    self.score = 0;
    self.deck = deck;
    if(self) {
        for(int i = 0; i<count;i++){
            SetCard *card = [self.deck drawSetRandomCard];
            if(card){
                [self.setCards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
    
}
- (NSUInteger)deckCards
{
    return [self.setCards count];
}


-(void)lastOne{
    NSMutableIndexSet * set = [[NSMutableIndexSet alloc]init];
    for(NSUInteger i = 0;i<3;i++){
        
        [set addIndex:i];
    }
    [self.setCards removeObjectsAtIndexes:set];
}

-(void)theRemoval:(NSMutableIndexSet *)set{
    NSIndexSet * s = set;
    [self.setCards removeObjectsAtIndexes:s];
}

////////Incorrect method of removing sets of objects/////////
-(NSMutableArray*)removeMatched{
        NSMutableArray * c = [[NSMutableArray alloc] init];
        for(SetCard * card in self.setCards){
            if(card.matched){
                [c addObject:card];
            }
        }
    return c;
}
-(void)removeEm:(NSMutableIndexSet *)nums{
    for(SetCard * card in self.setCards){
        if(card.matched){
            // for(NSNumber * p in nums){
            
            [self.setCards removeObjectsAtIndexes:nums];
            // [self.setCards removeobj:x];
            // }
        }
    }
}
-(NSMutableIndexSet*)removeCards{

    NSMutableIndexSet * c = [[NSMutableIndexSet alloc] init];
    for(NSUInteger i = 0;i < [self.setCards count]; i++){
        SetCard * p = [self setCardAtIndex:i];
        if(p.matched){
            [c addIndex:i];
        }
    }
   
    return c;
    
}
//////////////////////////////////////////////////////////
- (NSMutableIndexSet *)getMatches:(NSMutableArray *)cards
{
    NSMutableIndexSet *i =[[NSMutableIndexSet alloc] init];
  
        for (Card *card1 in cards) {
            NSUInteger * x = (NSUInteger *)[self.setCards indexOfObject:card1];
            [i addIndex: x];
        }
        return i;

}


-(void)addThreeCards:(NSUInteger*)n{

    if(n == 3){
    for(int i = 0;i<n;i++){
      
        SetCard *card = [self.deck drawSetRandomCard];
       
            [self.setCards addObject:card];


    }

    }
    
}



-(void)restartSet{
    for(SetCard * card in self.setCards){
        card.chosen = NO;
        card.matched = NO;
    }
    
}


-(Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}
-(SetCard *)setCardAtIndex:(NSUInteger)index{
    return (index<[self.setCards count]) ? self.setCards[index] : nil;
}

-(NSString *)gimme:(NSUInteger)i{
    id ok = self.setCards[i];
    SetCard * c = (SetCard *)ok;
    return c.contents;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
                   
-(void)chooseSetCardAtIndex:(NSUInteger)index{
    
    SetCard *card = [self setCardAtIndex:index];
    NSMutableAttributedString *stats = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:@"  "];
   

    if(!card.isMatched){
        
        self.cardType = [[NSMutableAttributedString alloc] init];
        
        if(card.isChsoen){

            card.chosen = NO;
           
        } else {
        
            //match against other card
            NSMutableArray *currentCard = [[NSMutableArray alloc] init];
   
            for(SetCard *otherCard in self.setCards){
                
                if(otherCard.isChsoen && !otherCard.isMatched){
   
                    [currentCard addObject:otherCard];
      
                    [stats appendAttributedString:space];
                    [stats appendAttributedString:[otherCard getSetContents]];
            
               }
        
            }
            
            if ([currentCard count]) {

              
                [self.cardType initWithString:@"Match with: "];
  
                [self.cardType appendAttributedString:[card getSetContents]];
                 [self.cardType appendAttributedString:stats];
                  self.store = NO;
                
            } else {
            
                [[self.cardType initWithString: @"Chose: " ] appendAttributedString:[card getSetContents]];
                self.store = NO;
            }
            
            
            
            if ([currentCard count] == 2) {
             
                int matchScore = [card match:currentCard];
                if(matchScore){
                    
                    for (SetCard *otherCard in currentCard) {
                        otherCard.matched = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                
                   
                    card.matched = YES;
 
                    self.cardType = [[NSMutableAttributedString alloc] initWithString:@"Match: "];
                 
                    [self.cardType appendAttributedString:[card getSetContents]];
          
                    NSString * points = [[NSString alloc] initWithFormat:@" Points: %d",matchScore*MATCH_BONUS-1];
                    NSAttributedString * point = [[NSAttributedString alloc] initWithString:points];
                  
                    
            
                    [self.cardType appendAttributedString:stats];
                    [self.cardType appendAttributedString:point];
                    self.store = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    
                    
                    for (SetCard *otherCard in currentCard) {
                        otherCard.chosen = NO;
                     
                    }
           
                    self.cardType = [[NSMutableAttributedString alloc] initWithString:@"No Match: "];
              
                    [self.cardType appendAttributedString:[card getSetContents]];
                    NSString * points = [[NSString alloc] initWithFormat:@" Deduct: %d",MISMATCH_PENALTY+1];
                    NSAttributedString * point = [[NSAttributedString alloc] initWithString:points];
                    
                    [self.cardType appendAttributedString:stats];
                    [self.cardType appendAttributedString:point];
                    self.store = YES;
                    card.matched = NO;
                    card.chosen = NO;

                }
     
                
              
            }
            self.score -= COST_TO_CHOOSE;
           card.chosen = YES;
            
        }
    }
}


-(void)chooseCardAtIndex:(NSUInteger)index{
 
    Card *card = [self cardAtIndex:index];
    NSMutableAttributedString *stats = [[NSMutableAttributedString alloc] init];
 
    if(!card.isMatched){
        self.cardType = [[NSMutableAttributedString alloc] init];
        if(card.isChsoen){
            card.chosen = NO;
        } else {
         
            NSMutableArray *currentCard = [[NSMutableArray alloc] init];
            
            for(Card *otherCard in self.cards){
                
                if(otherCard.isChsoen && !otherCard.isMatched){
                    [currentCard addObject:otherCard];
                    [stats initWithString:otherCard.contents];
                }
      
                [self.cardType initWithString:card.contents];
                [self.cardType appendAttributedString:stats];
            }
              
            if ([currentCard count]) {

                [self.cardType initWithString:@"Match with: "];
                 NSAttributedString * contents = [[NSAttributedString alloc] initWithString:card.contents];
                [self.cardType appendAttributedString:contents];
                [self.cardType appendAttributedString:stats];
                self.store = NO;
            } else {
                [self.cardType initWithString: @"Chose: " ];
                NSAttributedString * contents = [[NSAttributedString alloc] initWithString:card.contents];
                [self.cardType appendAttributedString:contents];
                self.store = NO;
            }
            
            
            
                  if ([currentCard count] == self.number) {
                      
                    int matchScore = [card match:currentCard];
                    if(matchScore){
                        for (Card *otherCard in currentCard) {
                            otherCard.matched = YES;
                        }
                        self.score += matchScore * MATCH_BONUS;
                        
                        card.matched = YES;
              
                        self.cardType = [[NSMutableAttributedString alloc] initWithString:@"Match: "];
                        NSAttributedString * contents = [[NSAttributedString alloc] initWithString:card.contents];
                        NSString * points = [[NSString alloc] initWithFormat:@"Points: %d",matchScore*MATCH_BONUS-1];
                        NSAttributedString * point = [[NSAttributedString alloc] initWithString:points];
                        
                        
                        [self.cardType appendAttributedString:contents];
                        [self.cardType appendAttributedString:stats];
                        [self.cardType appendAttributedString:point];
                        self.store = YES;
               
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *otherCard in currentCard) {
                            otherCard.chosen = NO;
                            self.store = YES;
                        }
                  
                        self.cardType = [[NSMutableAttributedString alloc] initWithString:@"No Match: "];
                        NSAttributedString * contents = [[NSAttributedString alloc] initWithString:card.contents];
                        NSString * points = [[NSString alloc] initWithFormat:@"Deduct: %d",MISMATCH_PENALTY+1];
                        NSAttributedString * point = [[NSAttributedString alloc] initWithString:points];
                        [self.cardType appendAttributedString:contents];
                        [self.cardType appendAttributedString:stats];
                        [self.cardType appendAttributedString:point];
          
                    }
             
                }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;

            }
        }
    }
//}

                   
@end
