//
//  SetCardView.m
//  Card
//
//  Created by Pete on 11/6/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];

}

- (void)setCount:(NSUInteger)count
{
    _count = count;
    [self setNeedsDisplay];
  
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade
{
    _shade = shade;
[self setNeedsDisplay];
}
- (void)setChosen:(BOOL)isChosen
{
    _isChosen = isChosen;
    [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor
{
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius
{
    return CORNER_RADIUS * [self cornerScaleFactor];
}
-(void) makeNew{
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
}
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    if(!self.isChosen){
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    }else {
        [[UIColor lightTextColor] setFill];
        UIRectFill(self.bounds);
    }
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self draw];
}

-(void)checkCount:(UIBezierPath *)path{
    if (self.count == 2) {
        
        UIBezierPath *leftPath = [path copy];
        CGAffineTransform left = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -.5, 0.0};
        
        CGAffineTransform right = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 *.5, 0.0};
        [leftPath applyTransform:left];
        [path applyTransform:right];
        
        [path appendPath:leftPath];
    } else if(self.count == 3) {
        
        UIBezierPath *leftPath= [path copy];
        UIBezierPath *rightPath = [path copy];
        CGAffineTransform left = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -1.0, 0.0};
        CGAffineTransform right= {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 , 0.0};
        
        [leftPath applyTransform:left];
        [rightPath applyTransform:right];
        
        [path appendPath:leftPath];
        [path appendPath:rightPath];
    }
}
-(void)checkFill:(UIBezierPath *)path{
    if ([self.shade isEqualToString:@"Solid"]) {
        
        [self.color setFill];
    } else if ([self.shade isEqualToString:@"Striped"]) {
        
        CGPoint left = CGPointMake(0, 0);
        CGPoint right = CGPointMake(self.bounds.size.width, 0);
        [path addClip];
        
        
       
      for(int i = 0; i <= self.bounds.size.height;i+=4){
            [path moveToPoint:left];
            [path addLineToPoint:right];
            left.y += 4;
            right.y += 4;
        }
    } else if([self.shade isEqualToString:@"Outlined"]){

    }

}
- (void)drawSquiggle
{

    
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGPoint start = CGPointMake(middle.x - (middle.x / 5), middle.y - (middle.y / 3));
    
    UIBezierPath *squig = [[UIBezierPath alloc] init];
    
    [squig moveToPoint:start];
 
    [squig addQuadCurveToPoint:CGPointMake(middle.x + middle.x/5, start.y) controlPoint:CGPointMake(middle.x, middle.y-(middle.y/2))];
      [squig addCurveToPoint:CGPointMake(middle.x + middle.x/5, middle.y + (middle.y / 3)) controlPoint1:CGPointMake(middle.x+(middle.x/5)+(middle.x/10), middle.y) controlPoint2:CGPointMake(middle.x, middle.y)];

    
    [squig addQuadCurveToPoint:CGPointMake(start.x, (middle.y + middle.y/3)) controlPoint:CGPointMake(middle.x, middle.y+(middle.y/2))];
    
    [squig addCurveToPoint:CGPointMake(start.x, start.y) controlPoint1:CGPointMake(middle.x-(middle.x/5)-(middle.x/10), middle.y) controlPoint2:CGPointMake(middle.x, middle.y)];

    [squig closePath];
 [self.color setStroke];
    [self checkCount:squig];
    [self checkFill:squig];
    [squig fill];
    
    [squig stroke];

}

- (void)drawOval
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGPoint start = CGPointMake(middle.x - (middle.x / 5), middle.y - (middle.y / 3));
    UIBezierPath *oval = [[UIBezierPath alloc] init];
    [oval moveToPoint:start];

    [oval addQuadCurveToPoint:CGPointMake(middle.x + middle.x/5, start.y) controlPoint:CGPointMake(middle.x, middle.y-(middle.y/2))];
    [oval addLineToPoint:CGPointMake(middle.x + (middle.x / 5), middle.y + (middle.y / 3))];
    [oval addQuadCurveToPoint:CGPointMake(middle.x - (middle.x / 5), middle.y + (middle.y / 3)) controlPoint:CGPointMake(middle.x , middle.y+(middle.y/2))];
    [oval closePath];
    [self.color setStroke];
    [self checkCount:oval];
    
  
    [self checkFill:oval];
    [oval fill];
    

    [oval stroke];

}


- (void)drawDiamond
{

    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    CGPoint top = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/4);

    
    [diamond moveToPoint:top];
        CGPoint right = CGPointMake(top.x+(top.x/3.5),
                                    top.y+top.y);
        [diamond addLineToPoint:right];
        CGPoint bottom = CGPointMake(top.x,
                                    top.y*3);
        [diamond addLineToPoint:bottom];
        CGPoint left = CGPointMake(top.x-(top.x/3.5),
                                     top.y+top.y);
        [diamond addLineToPoint:left];
        [diamond closePath];
    [self.color setStroke];
    
   [self checkCount:diamond];
    
    [self checkFill:diamond];
    
    [diamond fill];

    [diamond stroke];
    
}
-(void)draw{
        if([self.symbol isEqualToString:@"diamond"]){
            [self drawDiamond];
    }else if([self.symbol isEqualToString:@"oval"]){
        [self drawOval];
    } else{
        [self drawSquiggle];
    }
}
- (BOOL)matchIt:(SetCardView *)card1 Card2:(SetCardView *)card2
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
- (BOOL)match:(NSMutableArray *)card1 Card2:(NSMutableArray *)card2

{
     for(SetCardView * j in self){
         for(SetCardView * m in card1){
             for(SetCardView *k in card2){
           
            

    if ( ((j.count == m.count) && (j.count == k.count))
        || ( (j.count != m.count) && (j.count != k.count)
            && (m.count != k.count)) )
    {
        if ( ((self.symbol == m.symbol) && (j.symbol == k.symbol))
            || ( (self.symbol != m.symbol) && (j.symbol != k.symbol)
                && (m.symbol != k.symbol)) )
        {
            if ( ((j.color == m.color) && (j.color == k.color))
                || ( (j.color != m.color) && (j.color != k.color)
                    && (m.color != k.color)) )
            {
                if ( ((j.shade == m.shade) && (j.shade == k.shade))
                    || ( (j.shade != m.shade) && (j.shade != k.shade)
                        && (m.shade != k.shade)) )
                {
                    return true;
                    
                }
            }
        }
    }
    return false;
             }
         }
     }
    return false;
}


- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}


- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}



@end
