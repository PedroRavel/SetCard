//
//  SetViewController.m
//  Card
//
//  Created by Pete on 10/11/15.
//  Copyright (c) 2015 Pete. All rights reserved.
//

#import "SetViewController.h"
#import "SetDeck.h"
#import "SetCardDeck.h"
#import "GameHistoryController.h"
#import "SetCardView.h"
#import "Grid.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetViewController()
@property(nonatomic,strong)GameHistoryController *his;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UIView *mainview;


@property (strong,nonatomic) Grid *grid;
@property (strong,nonatomic) NSMutableArray *cgCells;
@property (weak, nonatomic) IBOutlet UILabel *cheatLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *getit;
@property (strong, nonatomic) SetCardView *scv;
@property (strong,nonatomic) NSMutableArray *indexCards;
@property (strong,nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSMutableIndexSet * cardsToRemove;
@property (strong, nonatomic) NSMutableArray * cardsToRemove1;

@property (nonatomic) int newCardsNum;
@end
@implementation SetViewController
-(CardMatchingGame *)game{
    if(!_game)_game = [[CardMatchingGame alloc] initWithSetCardCount:12 usingDeck:[self createSetDeck]];

    return _game;
}
-(NSMutableArray *)cardsToRemove{
    if(!_cardsToRemove) _cardsToRemove = [[NSMutableArray alloc] init];
    return _cardsToRemove;
}
-(NSMutableArray *)cardsToRemove1{
    if(!_cardsToRemove1) _cardsToRemove1 = [[NSMutableArray alloc] init];
    return _cardsToRemove1;
}
-(SetCardView *)scv{
    if(!_scv) _scv = [[SetCardView alloc]init];
    return _scv;
}
- (Grid *)grid
{
    if (!_grid)
    {
        _grid =[[Grid alloc] init];
        _grid.size = self.mainview.bounds.size;
        _grid.cellAspectRatio = 60.0/90.0f;
        _grid.minimumNumberOfCells = 12;
        if (!_grid.inputsAreValid) _grid =nil;
        
    }
    return _grid;
}
- (NSMutableArray *)cgCells
{
    if (!_cgCells) _cgCells= [[NSMutableArray alloc] init];
    return _cgCells;
}
- (NSMutableArray *)indexCards
{
    if (!_indexCards) _indexCards= [[NSMutableArray alloc] init];
    return _indexCards;
}
-(NSMutableArray *)getit{
    if(!_getit)_getit = [[NSMutableArray alloc] init];
    return _getit;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{

 if([segue.identifier isEqualToString:@"SetGame"]) {
     if ([segue.destinationViewController isKindOfClass:[GameHistoryController class]]) {
                     GameHistoryController *ghc = (GameHistoryController *) segue.destinationViewController;

         ghc.textToAnalyze = self.getit;
   
     }
    }
}

- (SetDeck *)createSetDeck
{
    return [[SetCardDeck alloc] init];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self start];
    [self updateUI];

}

- (NSArray *)cards
{
    if (!_cards)
    {
        _cards= [[NSMutableArray alloc] init];
        NSUInteger col =self.grid.columnCount;
        self.cgCells =nil;
        self.indexCards =nil;
        
        NSUInteger j =0;
        for (NSUInteger i=0; i<= [self.game deckCards]-1/*+self.newCardsNum*/; i++) {
            SetCard *setCard = [self.game setCardAtIndex:i];
            NSUInteger row = (j+0.5)/col;
            NSUInteger column =j%col;
            
            CGPoint center = [self.grid centerOfCellAtRow:row inColumn:column];
            CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
            
            CGRect frames = CGRectInset(frame,
                                        frame.size.width * (.1),
                                        frame.size.height * (.1));

            SetCardView *setCardView = [[SetCardView alloc]  initWithFrame:frames];
            setCardView.opaque = NO;

            
            setCardView.count = setCard.count;
            setCardView.symbol = setCard.symbol;

            setCardView.color = setCard.color;
            setCardView.shade = setCard.shade;

            setCardView.isChosen = setCard.isChsoen;
            UIView *cardView = setCardView;
            
            [_cards addObject:cardView];
            self.cgCells[j]= [NSValue valueWithCGPoint:center];
            self.indexCards[j]= [NSNumber numberWithInteger: i];
            j++;
        }
    }
    return _cards;
}


- (IBAction)tap:(UITapGestureRecognizer *)sender {
    CGPoint p = [sender locationInView:self.mainview];
    NSUInteger col =self.grid.columnCount;
    CGSize cell =self.grid.cellSize;
    NSUInteger column = p.x/cell.width+1;
    NSUInteger row = p.y/cell.height+1;
    NSUInteger point =(row-1)*col +column-1;
    if(point < [[self.game currentSetDeck] count])
    [self.game chooseSetCardAtIndex:point];
 
    SetCard * card = [self.game setCardAtIndex:point];
    
    [self updateUI];

        if(card.isMatched){

            [self cardViewRemove];

         
    }
}

- (void)start
{
    NSMutableArray * subs = [[NSMutableArray alloc] initWithArray:[self.mainview subviews]];
    
    NSLog(@"%dSUB",[subs count]);
    NSLog(@"%dVIEWS",[self.cards count]);
    for(int i = 0; i<[subs count];i++)
        [subs[i] removeFromSuperview];
    
    
    self.cards =nil;
	CGPoint point = CGPointMake((self.mainview.bounds.size.width)+(self.mainview.bounds.size.width/6) , self.mainview.bounds.size.height*2);
    
    float slow=0;
    
    for (UIView *singleView in self.cards) {
        if (singleView.hidden==NO)
        {
        singleView.center = point;
        [self.mainview addSubview:singleView];
        [UIView animateWithDuration:0.65f
                              delay:0.2f+slow
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             
             int index = [self.cards indexOfObject:singleView];
             CGPoint center = [self.cgCells[index] CGPointValue];
             singleView.center = center;
             
         }
                         completion:nil];
        
        slow+=.09;
        }
    }
    
}
- (void)cardViewRemove
{
    
    NSMutableArray *remove = [NSMutableArray array];
    
    NSIndexSet *i=[self.game getMatches:[self.game removeMatched]];
    [i enumerateIndexesUsingBlock:^(NSUInteger j, BOOL *stop) {
        [remove addObject:self.cards[j]];
    }];
    [self animateRemovingDrops:remove];
}

- (void)animateRemovingDrops:(NSArray *)dropsToRemove
{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        for (UIView *drop in dropsToRemove) {
            
            int x = (arc4random())%(int)(self.mainview.bounds.size.width*5) -
            (int)self.mainview.bounds.size.width*2;
            
            int y = (int)self.mainview.bounds.size.height;
            drop.center = CGPointMake(x, -y);
            
        }
    }
                     completion:^(BOOL finished) {
                         for (UIView *drop in dropsToRemove) {
                             NSUInteger indexView =[self.cards indexOfObject:drop];
                             ((UIView *)self.cards[indexView]).hidden = YES;
                         }

                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                        NSMutableIndexSet * l = [self.game getMatches:[self.game removeMatched]];

                         [self.game theRemoval:l];
                         self.grid.minimumNumberOfCells =[[self.game currentSetDeck] count];
                         [self start];

                     }];
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
        [UIView animateWithDuration:0.65f
                              delay:0.2f//+slow
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             
             int index = [self.cards indexOfObject:singleView];
             CGPoint center = [self.cgCells[index] CGPointValue];
             singleView.center = center;
             
         }
                         completion:nil];
        
        slow+=.2;
    }
    
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
-(void)updateUI{
    

    for (int i=0; i< [self.game deckCards];i++)
    {
        //NSLog(@"%d",i);
        
        int index = [self.indexCards[i] integerValue];
        
        UIView *cell = self.cards[index];
  
        SetCard *setCard = [self.game setCardAtIndex:index];

        SetCardView *setCardView = (SetCardView *)cell;
            setCardView.count = setCard.count;
            setCardView.symbol = setCard.symbol;
            
            setCardView.color = setCard.color;
            setCardView.shade = setCard.shade;
            
            if (setCardView.isChosen != setCard.isChsoen) {
                [UIView transitionWithView:setCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    setCardView.isChosen = setCard.isChsoen;
                                    
                                    
                                } completion:NULL];
                
                setCardView.isChosen = setCard.isChsoen;
            }
        
    }
      self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
}
-(void)dealEm{
    NSUInteger j = [self.cards count];
    NSUInteger k = [self.cards count];
    NSUInteger columnCount =self.grid.columnCount;
    
    NSMutableArray *addedCards = [NSMutableArray array];
    for (NSUInteger i=j; i< j+3; i++) {
 
        Card *card = [self.game setCardAtIndex:i];
        NSUInteger row = (k+0.5)/columnCount;
        NSUInteger column =k%columnCount;
        
        CGPoint center = [self.grid centerOfCellAtRow:row inColumn:column];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        
        CGRect frames = CGRectInset(frame,
                                    frame.size.width * (.1),
                                    frame.size.height * (.1));
     
        SetCard *setCard =(SetCard *)card;
        SetCardView *newSetCardView = [[SetCardView alloc]  initWithFrame:frames];
        newSetCardView.symbol = setCard.symbol;
        
        newSetCardView.color = setCard.color;
        newSetCardView.shade = setCard.shade;
  
        setCard.chosen = NO;
        newSetCardView.isChosen = setCard.isChsoen;
        UIView *cardView = newSetCardView;
        cardView.opaque = NO;
        [self.cards addObject:cardView];
        self.cgCells[k]= [NSValue valueWithCGPoint:center];
        self.indexCards[k]= [NSNumber numberWithInteger: i];
        [addedCards addObject:cardView];
        k++;

        {

            
        }
        
    }
    [self addEm:addedCards];
    
    
}
-(void)addEm:(NSArray *)flashCards{
    float p = 0;
    CGPoint point = CGPointMake(self.mainview.bounds.size.width/2 , self.mainview.bounds.size.height*2);
    
    for(UIView *flash in flashCards){
        if(!flash.hidden){
        flash.center = point;
        [self.mainview addSubview:flash];
        
        [UIView animateWithDuration:0.65f
                              delay:0.5f+(p+0.2f)
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             
             
             int index = [self.cards indexOfObject:flash];
             CGPoint center = [self.cgCells[index] CGPointValue];
             flash.center = center;
             
         }
                         completion:nil];
        p+=.01;
        
        }
    }
}

-(void)deleteEm:(NSArray *)flashCards{
    float p = 0;
    CGPoint point = CGPointMake(self.mainview.bounds.size.width/2 , self.mainview.bounds.size.height*2);
    for(UIView *flash in flashCards){
        
    }
    for(UIView *flash in flashCards){
        flash.center = point;
        [self.mainview addSubview:flash];
        
        [UIView animateWithDuration:0.65f
                              delay:0.5f+(p+0.2f)
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             
             
             int index = [self.cards indexOfObject:flash];
             CGPoint center = [self.cgCells[index] CGPointValue];
             flash.center = center;
             
         }
                         completion:nil];
        p+=.01;
        
        //}
    }
}
-(BOOL)cheats:(BOOL)displayCheats{
    
    NSMutableArray *copy = [self.cards mutableCopy];
    NSLog(@"%d",[[self.game currentSetDeck] count]);
    for(int i = 0;i<[[self.game currentSetDeck] count]; i++){
        for(int j = i+1; j <[[self.game currentSetDeck] count]; j++){
            for(int k = j+1; k<[[self.game currentSetDeck] count];k++){
                SetCardView * q = copy[i];
                SetCardView * w = copy[j];
                SetCardView * e = copy[k];
                SetCard * r = (SetCard*)copy[i];
                SetCard * t = (SetCard*)copy[j];
                SetCard * y = (SetCard*)copy[k];
                if([q matchIt:w Card2:e]){
                    
                    NSLog(@"%@",@"CHEATER");
                    if(displayCheats){
                        [copy[i] setAlpha:.5];
                        [copy[j] setAlpha:.5];
                        [copy[k] setAlpha:.5];
                    }
                    return true;
                    
                }
            }
        }
    }
    return false;
}
- (IBAction)hint:(id)sender {


    [self cheats:YES];
   
 
   
    
}
- (IBAction)reDeal:(id)sender {
    self.newCardsNum = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
   self.cheatLabel.text = @"";
    _grid =[[Grid alloc] init];
    _game = [[CardMatchingGame alloc] initWithSetCardCount:12 usingDeck:[self createSetDeck]];
     _grid =[[Grid alloc] init];
    self.grid.size = self.mainview.bounds.size;
    self.grid.cellAspectRatio = 60.0/90.0f;
    self.grid.minimumNumberOfCells = 12;
    [self start];

}


- (IBAction)dealThree:(id)sender {
    
 
    if([self cheats:NO]&&[[self.game currentSetDeck] count]<52){
        self.cheatLabel.text = @"Set Found. 5 Point penalty";
        [self.game deductCheat];
    }
    else {
        self.cheatLabel.text = @"";
    }
    if([[self.game currentSetDeck] count]<52){
    [self.game addThreeCards:3];
    NSLog(@"%d",[self.cards count]);

    self.grid.size = self.mainview.bounds.size;
    self.grid.cellAspectRatio = 60.0/90.0f;
    self.grid.minimumNumberOfCells = [self.game deckCards];
    [self start];

   
    } else {
        self.cheatLabel.text = @"Reached card limit";
    }
 [self updateUI];
}



@end


