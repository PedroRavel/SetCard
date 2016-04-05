//
//  GameHistoryController.m
//  Card
//
//  Created by Pete on 10/12/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "GameHistoryController.h"
#import "CardMatchingGame.h"

@interface GameHistoryController()
@property (weak, nonatomic) IBOutlet UITextView *history;
@property(strong, nonatomic) CardMatchingGame *game;
@property(weak,nonatomic) NSMutableAttributedString *contents;
@property(strong,nonatomic) NSMutableAttributedString *content;



@end
@implementation GameHistoryController
@synthesize test = _test;
-(NSMutableAttributedString *)content{
    if(!_content)_content = [[NSMutableAttributedString alloc] init];
    return _content;
}
-(void)setTest:(NSAttributedString *)choose{
    self.test = choose;
}
-(NSAttributedString *)test{
    return _test;
}
- (void)setTextToAnalyze:(NSMutableArray *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI{
    

    self.history.attributedText = [self getStrings];

}
-(NSMutableAttributedString *)getString{
    
    return self.content;
}
-(NSMutableAttributedString *)getStrings{
    

    NSAttributedString * space = [[NSAttributedString alloc] initWithString:@"\n"];
        for(NSAttributedString * s in self.textToAnalyze){
            [self.content appendAttributedString:s];
            [self.content appendAttributedString:space];
            
  
        }
    
    return self.content;
}



@end
