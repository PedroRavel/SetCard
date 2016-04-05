//
//  Card.m
//  Card
//
//  Created by Pete on 9/14/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "Card.h"
@interface Card()

@end

@implementation Card

@synthesize contents = _contents;
@synthesize set = _set;
@synthesize color = _color;
@synthesize chosen = _chosen;
@synthesize matched = _matched;
@synthesize count = _count;

- (NSString *)contents
{
    return _contents;
}
-(NSString *)set{
    return _set;
}
- (UIColor *)color
{
    return _color;
}
-(NSUInteger)count{
    return _count;
}
-(float)shade{
    return _shade;
}
-(void)setContents:(NSString *)contents
{
    _contents = contents;
}

- (BOOL)isChosen
{
    return _chosen;
}

-(void)setChosen:(BOOL)chosen
{
    _chosen = chosen;
}

- (BOOL)isMatched
{
    return _matched;
}

- (void)setMatched:(BOOL)matched
{
    _matched = matched;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

@end
