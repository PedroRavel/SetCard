//
//  SetCard.m
//  Card
//
//  Created by Pete on 10/11/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard




-(int)match:(NSArray *)otherCards{
    int score = 0;

        NSMutableArray *copyCards = [otherCards mutableCopy];
        for (SetCard *otherCard in otherCards) {
            [copyCards removeObject:otherCard];
            for (SetCard *copyCard in copyCards) {
                if([self match:otherCard Card2:copyCard]){
                    score+=4;
                } else {
                
                }
        }
    }
    return score;
}

- (NSString *)contents
{
    return self.symbol;
}
@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize count = _count;
@synthesize shade = _shade;
@synthesize contents = _contents;
@synthesize chosen = _chosen;
@synthesize matched = _matched;
-(NSUInteger)count{
    return _count;
}
-(NSString*)shade{
    if(!_shade) _shade = [[NSString alloc]init];
    return _shade;
}
- (BOOL)isMatched
{
    return _matched;
}
- (BOOL)isChosen
{
    return _chosen;
}
-(void)setChosen:(BOOL)chosen
{
    _chosen = chosen;
}



- (void)setMatched:(BOOL)matched
{
    _matched = matched;
}

+ (NSArray *) validSets
{
    //return @[@"○",@"○○",@"○○○",@"☐",@"☐☐",@"☐☐☐",@"△",@"△△",@"△△△"];
    //return @[@"●",@"●●",@"●●●",@"■",@"■■",@"■■■",@"▲",@"▲▲",@"▲▲▲"];
    return @[@"diamond",@"oval",@"squiggle"];
            // ,@"○",@"○○",@"○○○",@"☐",@"☐☐",@"☐☐☐",@"△",@"△△",@"△△△"];
}

+ (NSArray *) validShades
{
    return @[@"Solid", @"Striped", @"Outlined"];

}
+ (NSArray *) validCounts
{
    return @[@1, @2, @3];
    
}

+ (NSArray *) validColors
{
    return @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor]];
}
-(UIColor*)colors{
    return self.color;
}

-(NSAttributedString *)getSetContents{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.contents];
    [title setAttributes:@{ NSStrokeColorAttributeName:  [self.color colorWithAlphaComponent:1],NSStrokeWidthAttributeName: @-5,NSForegroundColorAttributeName:[self.color colorWithAlphaComponent: (float).2f]
                            } range:NSMakeRange(0, [self.contents length])];
    return title;
}

//-(float)shade{
//    return self.shade;
//}
- (BOOL)match:(SetCard *)card1 Card2:(SetCard *)card2
{
    if ( ((self.count == card1.count) && (self.count == card2.count))
        || ( (self.count != card1.count) && (self.count != card2.count)
            && (card1.count != card2.count)) )
    {
        if ( ((self.symbol == card1.symbol) && (self.symbol == card2.symbol))
            || ( (self.symbol != card1.symbol) && (self.symbol != card2.symbol)
                && (card1.symbol != card2.symbol)) )
        {
            if ( ((self.color == card1.color) && (self.color == card2.color))
                || ( (self.color != card1.color) && (self.color != card2.color)
                    && (card1.color != card2.color)) )
            {
                if ( ((self.shade == card1.shade) && (self.shade == card2.shade))
                    || ( (self.shade != card1.shade) && (self.shade != card2.shade)
                        && (card1.shade != card2.shade)) )
                {
                    return true;
                    
                }
            }
        }
    }
    return false;
}
- (void)setCard:(NSString *)set
{


    if([[SetCard validSets] containsObject:set]) {
        _symbol = set;
    }
}
- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
    //return self.set;
}

@end
