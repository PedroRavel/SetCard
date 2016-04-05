//
//  SetCardView.h
//  Card
//
//  Created by Pete on 11/6/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) NSString *shade;
@property (nonatomic) BOOL isChosen;
-(void) makeNew;
- (BOOL)match:(NSMutableArray *)card1 Card2:(NSMutableArray *)card2;
- (BOOL)matchIt:(SetCardView *)card1 Card2:(SetCardView *)card2;
@end
