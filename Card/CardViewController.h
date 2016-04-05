//
//  CardViewController.h
//  Card
//
//  Created by Pete on 9/14/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
@interface CardViewController : UIViewController
@property (weak, readonly) IBOutlet UILabel *gameText;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, readonly) NSMutableArray *getit;
-(Deck *)createDeck;

@end
