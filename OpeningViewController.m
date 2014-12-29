//
//  OpeningViewController.m
//  TicTacToe
//
//  Created by Jason Hoffman on 12/23/14.
//  Copyright (c) 2014 No5age. All rights reserved.
//

#import "OpeningViewController.h"
#import "GameViewController.h"

@interface OpeningViewController ()

@property (weak, nonatomic) IBOutlet UIButton *xButton;
@property (weak, nonatomic) IBOutlet UIButton *oButton;

@end

@implementation OpeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *xImage = [UIImage imageNamed:@"xImage"];
    UIImage *oImage = [UIImage imageNamed:@"oImage"];
    
    [self.xButton setImage:xImage forState:UIControlStateNormal];
    [self.oButton setImage:oImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"xButtonSelected"]) {
        GameViewController *gvc = segue.destinationViewController;
        gvc.playerIsX = YES;
        gvc.playerIsO = NO;
        
    }
    
    if ([segue.identifier isEqualToString:@"oButtonSelected"]) {
        GameViewController *gvc = segue.destinationViewController;
        gvc.playerIsX = NO;
        gvc.playerIsO = YES;
    }
}

- (IBAction)unwindToOpeningView:(UIStoryboardSegue *)unwindSegue
{
    // Clear game stuff
}

@end
