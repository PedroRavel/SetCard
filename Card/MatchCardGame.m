//
//  MatchCardGame.m
//  Card
//
//  Created by Pete on 10/10/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "MatchCardGame.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameHistoryController.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
#import "Grid.h"
#import "CardViewController.h"


@interface MatchCardGame ()
@property NSMutableArray* newArr;
@property (strong,nonatomic) Grid *grid;


@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (strong,nonatomic) NSMutableArray *cells;
@property (nonatomic) BOOL didLoad;
@property (strong,nonatomic) NSMutableArray *indexCards;
@property (strong,nonatomic) NSMutableArray *cards;
@property (weak, nonatomic) IBOutlet UIButton *scoreLabel;




@property (nonatomic) int newCardsNum;
@property int firstTime;
@property PlayingCardView* pcv;
@end

@implementation MatchCardGame
-(NSMutableArray *)newArr{
    if(!_newArr)_newArr = [[NSMutableArray alloc]init];
    return _newArr;
}
-(PlayingCardView *)pcv{
    if(!_pcv) _pcv = [[PlayingCardView alloc]init];
    return _pcv;
}
//-(int)newCardsNum{
 //   if(!_newCardsNum) _newCardsNum = 0;
  //  return _newCardsNum;
//}
-(Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MatchGame"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryController class]]) {
            GameHistoryController *ghc = (GameHistoryController *) segue.destinationViewController;
            CardViewController *cvc = (CardViewController *)sender;
        
            ghc.textToAnalyze = self.getit;
        
        }
    }
}
- (NSMutableArray *)cells
{
    if (!_cells) _cells= [[NSMutableArray alloc] init];
    return _cells;
}
- (NSMutableArray *)indexCards{
    if (!_indexCards) _indexCards= [[NSMutableArray alloc] init];
    return _indexCards;
}
- (Grid *)grid
{
    if (!_grid)
    {
        _grid =[[Grid alloc] init];
        _grid.size = self.mainview.bounds.size;
        _grid.cellAspectRatio = 90.0/60.0f;
        _grid.minimumNumberOfCells = 10;
        if (!_grid.inputsAreValid) _grid =nil;
        
    }
    return _grid;
}

- (NSArray *)cards
{
    if (!_cards)
    {
        _cards= [[NSMutableArray alloc] init];
       // self.cells =nil;
        //self.indexCards =nil;
        NSUInteger col =self.grid.columnCount;
        
        
        NSUInteger j =0;
        for (NSUInteger i=0; i<= 47+self.newCardsNum; i++) {
            Card *card = [self.game cardAtIndex:i];
            NSUInteger row = (j)/col;
            NSUInteger column =j%col;
            
            CGPoint center = [self.grid centerOfCellAtRow:row inColumn:column];
            CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
            
            CGRect frames = CGRectInset(frame,
                                        frame.size.width* (.1),
                                        frame.size.height* (.1));
            PlayingCard *playingCard =(PlayingCard *)card;
            PlayingCardView *playingCardView = [[PlayingCardView alloc]  initWithFrame:frames];
            playingCardView.opaque = NO;
            playingCardView.rank=playingCard.rank;
            playingCardView.suit=playingCard.suit;
            playingCardView.faceUp=playingCard.isChsoen;
            UIView *cardView = playingCardView;
            [_cards addObject:cardView];
            self.cells[j]= [NSValue valueWithCGPoint:center];
            self.indexCards[j]= [NSNumber numberWithInteger: i];
            j++;
        }
    }
    return _cards;
}

-(void)dealEm{
    NSUInteger j = [self.cards count];
    NSUInteger k = [self.cards count];
    NSUInteger columnCount =self.grid.columnCount;
 
    NSMutableArray *cardsViewToInsert = [NSMutableArray array];
    for (NSUInteger i=j; i< j+3; i++) {
        self.newCardsNum++;
        Card *card = [self.game cardAtIndex:i];
        NSUInteger row = (k+0.5)/columnCount;
        NSUInteger column =k%columnCount;
        
        CGPoint center = [self.grid centerOfCellAtRow:row inColumn:column];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        
        CGRect frames = CGRectInset(frame,
                                    frame.size.width * (.1),
                                    frame.size.height * (.1));
        UIView *cardView = [self.pcv cellViewForCard:card inRect:frames];
        [self.cards addObject:cardView];
        self.cells[k]= [NSValue valueWithCGPoint:center];
        self.indexCards[k]= [NSNumber numberWithInteger: i];
        [cardsViewToInsert addObject:cardView];
        k++;
             {
        }
        
    }
   [self addEm:cardsViewToInsert];
    
    
}
-(void)addEm:(NSArray *)flashCards{
    float p = 0;
    CGPoint point = CGPointMake(self.mainview.bounds.size.width/2 , self.mainview.bounds.size.height*2);
   
    for(UIView *flash in flashCards){
         flash.center = point;
        [self.mainview addSubview:flash];
        
    [UIView animateWithDuration:1.65f
                          delay:0.5f+(p+0.2f)
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         
         
         int index = [self.cards indexOfObject:flash];
         CGPoint center = [self.cells[index] CGPointValue];
         flash.center = center;
         
     }
                     completion:nil];
    p+=.2;
    
    //}
}
}
- (IBAction)dealThree:(id)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:52 usingDeck:[self createDeck]];
    [self start];
    [self updateUI];
 

}

- (void)start
{
    NSMutableArray * subs = [[NSMutableArray alloc] initWithArray:[self.mainview subviews]];
    for(int i = 0; i<[subs count];i++)
        [subs[i] removeFromSuperview];
    

    self.cards =nil;
	CGPoint point = CGPointMake((self.mainview.bounds.size.width)+(self.mainview.bounds.size.width/6) , self.mainview.bounds.size.height*2);
    
    float slow=0;
  
    for (UIView *singleView in self.cards) {
        singleView.center = point;
        [self.mainview addSubview:singleView];
        [UIView animateWithDuration:0.2f
                              delay:0.2f+slow
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
       
             int index = [self.cards indexOfObject:singleView];
             CGPoint center = [self.cells[index] CGPointValue];
             singleView.center = center;
             
         }
                         completion:nil];
    
        slow+=.08;
    }
    
}
- (void)restart
{
    NSMutableArray * subs = [[NSMutableArray alloc] initWithArray:[self.mainview subviews]];
    for(int i = 0; i<[subs count];i++)
        [subs[i] removeFromSuperview];
    
    
    self.cards =nil;
	CGPoint point = CGPointMake(self.mainview.bounds.size.width/2 , self.mainview.bounds.size.height*2);
    
    float slow=0;
    
    for (UIView *singleView in self.cards) {
        singleView.center = point;
        [self.mainview addSubview:singleView];
        [UIView animateWithDuration:3.65f
                              delay:0.92f//+slow
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             
             int index = [self.cards indexOfObject:singleView];
             CGPoint center = [self.cells[index] CGPointValue];
             singleView.center = center;
             
         }
                         completion:nil];
        
        slow+=.2;
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    [self start];
}


- (IBAction)tap:(UITapGestureRecognizer *)sender {
  
    CGPoint p = [sender locationInView:self.mainview];
    NSUInteger col =self.grid.columnCount;
    CGSize cell =self.grid.cellSize;
    NSUInteger column = p.x/cell.width+1;
    NSUInteger row = p.y/cell.height+1;
    NSUInteger point =(row-1)*col +column-1;
    if(point<=47){
    [self.game chooseCardAtIndex:point];
        
    
    }

[self updateUI];
}
-(void)updateUI{
   

    for (int i=0; i<[self.cards count];i++)
    {
        int index = [self.indexCards[i] integerValue];
        UIView *cell = self.cards[index];
        PlayingCard *playingCard = [self.game cardAtIndex:index];
    
        PlayingCardView *playingCardView = (PlayingCardView *)cell;

            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            if (playingCardView.faceUp != playingCard.isChsoen) {
                
                [UIView transitionWithView:playingCardView
                                  duration:1.0                                   options:UIViewAnimationOptionTransitionFlipFromTop
                                animations:^{
                                    playingCardView.faceUp = playingCard.isChsoen;
                                } completion:NULL];
                
            }
        
    }
    
    [self.scoreLabel setTitle:[NSString stringWithFormat:@"Score: %ld", (long)self.game.score]forState:UIControlStateNormal];

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];

}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
  
   
    self.grid.size = self.mainview.bounds.size;
    self.grid.cellAspectRatio = 60.0/90.0f;
    self.grid.minimumNumberOfCells = [self.cards count];

    [self start];
    [self updateUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
