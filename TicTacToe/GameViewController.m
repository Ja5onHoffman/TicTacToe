//
//  GameViewController.m
//  TicTacToe
//
//  Created by Jason Hoffman on 12/23/14.
//  Copyright (c) 2014 No5age. All rights reserved.
//

#import "GameViewController.h"
#import "GridView.h"
#import "HudView.h"


@interface GameViewController ()

@property (nonatomic) NSInteger selectedButtonColumn;
@property (nonatomic) NSInteger selectedButtonRow;
@property (nonatomic, strong) NSMutableArray *gameBoard;
@property (nonatomic, strong) NSMutableDictionary *score;
@property (nonatomic, strong) NSArray *buttonIndex;
@property (nonatomic, strong) GridView *gridView;
@property (nonatomic) BOOL playerTurn;
@property (nonatomic) int playerScore;
@property (nonatomic) int computerScore;
@property (nonatomic) int turn;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *computerScoreLabel;

@end


@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    self.navigationController.navigationBarHidden = YES;
    NSLog(@"playerChoice %d", self.playerIsX);
    self.playerScore = 0;
    self.computerScore = 0;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%i", self.playerScore];
    self.computerScoreLabel.text = [NSString stringWithFormat:@"%i", self.computerScore];
    
    // Using Objective-C's version of a 2D array
    NSMutableArray *row1 = [NSMutableArray arrayWithObjects:@0, @0, @0, nil];
    NSMutableArray *row2 = [NSMutableArray arrayWithObjects:@0, @0, @0, nil];
    NSMutableArray *row3 = [NSMutableArray arrayWithObjects:@0, @0, @0, nil];
    self.gameBoard = [NSMutableArray arrayWithObjects:row1, row2, row3, nil];
    
    // Button 2D array that mirrors the gameboard
    self.buttonIndex = @[@[self.button1, self.button2, self.button3],
                         @[self.button4, self.button5, self.button6],
                         @[self.button7, self.button8, self.button9]];
    
    // Not currently used but will be for keeping score
    /*self.score = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"X", self.playerScore, @"O", self.computerScore, nil]; */
    
    // Track turns with a turn counter
    self.turn = 0;
    
    // If playerIsX, player goes first
    if (self.playerIsX) {
        self.playerTurn = YES;
    } else {
        self.playerTurn = NO;
        [self randomTurn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TicTacToe game AI

- (IBAction)buttonSelected:(UIButton *)sender
{
    
    __block NSInteger column = 0;
    __block NSInteger row = 0;
    
    // Increment turn
    self.turn++;
    
    // Capture row and column of selected cell
    UIButton *button = sender;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if ([button isEqual:self.buttonIndex[i][j]]) {
                row = i;
                column = j;
            }
        }
    }
    
    if (self.playerIsX) {
        
        // Player is always '1' on gameboard regardless if playing as X or O
        if ([self.gameBoard[row][column] isEqual:@0]) {
            UIImage *image = [UIImage imageNamed:@"xImage"];
            [button setBackgroundImage:image forState:UIControlStateNormal];
            
            // Player is always '1' on gameboard regardless if playing as X or O
            [[self.gameBoard objectAtIndex:row] replaceObjectAtIndex:column withObject:@1];
            self.playerTurn = NO;
            [self randomTurn];
        }
        
    } else {
        
        if ([self.gameBoard[row][column] isEqual:@0]) {
            
            UIImage *image = [UIImage imageNamed:@"oImage"];
            [button setBackgroundImage:image forState:UIControlStateNormal];
            [[self.gameBoard objectAtIndex:row] replaceObjectAtIndex:column withObject:@1];
            self.playerTurn = NO;
            [self randomTurn];
        }
    }
}

// Haven't come up with game logic yet and didn't want to copy an AI from the web
// so for now the computer plays randomly.
- (void)randomTurn
{
    NSMutableArray *emptyCells = [[NSMutableArray alloc] init];
    
    // Keep coordinates of empty cells then randomly choose cell
    NSArray *pair;
    self.turn++;
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if ([self.gameBoard[i][j] isEqual: @0]) {
                pair = @[[NSNumber numberWithInt:i],[NSNumber numberWithInt:j]];
                [emptyCells addObject:pair];
            }
        }
    }
    
    // If emptyCells.count == 0, game is over
    if (emptyCells.count > 0) {
        NSUInteger r1 = arc4random_uniform((int)emptyCells.count);
        NSArray *num = [emptyCells objectAtIndex:r1];
        
        UIImage *image;
        if (self.playerIsX) {
            image = [UIImage imageNamed:@"oImage"];
        } else {
            image = [UIImage imageNamed:@"xImage"];
        }
        
        // Get button random coordinate
        UIButton *button = [[self.buttonIndex objectAtIndex:[num[0] integerValue]] objectAtIndex:[num[1] integerValue]];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        
        // ...And change cell value to 2
        [[self.gameBoard objectAtIndex:[num[0] integerValue]] replaceObjectAtIndex:[num[1] integerValue] withObject:@2];
        self.playerTurn = YES;
    } else {
        NSLog(@"Game over");
    }
    
    [self checkForWinner];
}

- (void)checkForWinner
{
    // Doesn't determine if X or O is winner yet
    NSLog(@"turn %d", self.turn);
    NSArray *gameBoard = [self.gameBoard copy];
    
    // Would like to come up with a more elegant version of this instead of forcing it with if statements
    if (self.turn >= 5) {
    
        if (gameBoard[0][0] == gameBoard[0][1] && gameBoard[0][1] == gameBoard[0][2]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[1][0] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[1][2]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[2][0] == gameBoard[2][1] && gameBoard[2][1] == gameBoard[2][2]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[0][0] == gameBoard[1][0] && gameBoard[1][0] == gameBoard[2][0]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[0][1] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][1]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[0][2] == gameBoard[1][2] && gameBoard[1][2] == gameBoard[2][2]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[0][0] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][2]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else if (gameBoard[0][2] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][0]) {
            if (self.playerIsX || self.playerIsO) {
                NSLog(@"Player wins");
            } else {
                NSLog(@"Computer wins");
            }
            [self endGame];
            
        } else {
            NSLog(@"No winner");
        
        }
    }
}


/*
- (void)takeTurn
{
    NSArray *gameBoard = [self.gameBoard copy];
    
    if (gameBoard[0][0] == gameBoard[0][1] || gameBoard[2][2] == gameBoard[1][2]) {
        // gameBoard[0][2];
    } else if (gameBoard[1][0] == gameBoard[1][1]) {
        // gameboard[1][2]
    } else if (gameBoard[2][0] == gameBoard[2][1]) {
        // gameBoard[2][2]
    } else if (gameBoard)
} */

/*
 *
 *  00 01 02
 *  10 11 12
 *  20 21 22
 *
 */

- (void)endGame
{
    // Redundant here. Needs 'player wins' or 'player loses'
    if (self.playerIsX || self.playerIsO) {
        
        self.playerScore++;
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%i", self.playerScore];
        HudView *hudView = [HudView hudInView:self.navigationController.view withMessage:@"Player Won!" animated:YES];

    } else {
        
        self.computerScore++;
        self.computerScoreLabel.text = [NSString stringWithFormat:@"%i", self.computerScore];
        HudView *hudView = [HudView hudInView:self.navigationController.view withMessage:@"Computer Won!" animated:YES];
    }
}

@end
