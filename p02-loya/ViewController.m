//
//  ViewController.m
//  p02-loya
//
//  Created by Harshad Loya on 2/5/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize Title;
@synthesize Tiles;
@synthesize Reset;
@synthesize Score;
bool startOfNewGame;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializing the game
    startOfNewGame = true;
    [self randomNumberGenerator];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)randomNumberGenerator
{
    //Initializes 2 random blocks with 2 to start the game
    if(startOfNewGame)
    {
        NSInteger x = arc4random_uniform(16);
        if([[[Tiles objectAtIndex:x] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:x] setText:@"2"];
        }
        
        NSInteger y = arc4random_uniform(16);
        while (y == x)
        {
            y = arc4random_uniform(16);
        }
        
        if([[[Tiles objectAtIndex:y] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:y] setText:@"2"];
        }
        startOfNewGame = false;
    }
    else
    {
        NSInteger x = arc4random_uniform(16);
        if([[[Tiles objectAtIndex:x] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:x] setText:@"2"];
        }
    }
}

-(IBAction)startOver
{
    NSInteger i=0;
    double j=0;
    while(j<=15)
    {
        [[Tiles objectAtIndex:i] setText:@""];
        i=i+1;
        j=i;
    }
    [Score setText:@"Score 1"];
    startOfNewGame = true;
    [self randomNumberGenerator];
}

@end
