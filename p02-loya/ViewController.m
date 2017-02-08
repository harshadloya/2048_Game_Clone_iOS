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
@synthesize Score;
bool startOfNewGame;
int score;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializing the game
    startOfNewGame = true;
    [Score setText:@"0"];
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
        while(![[[Tiles objectAtIndex:x] text] isEqual:@""])
        {
            x = arc4random_uniform(16);
        }
        if([[[Tiles objectAtIndex:x] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:x] setText:@"2"];
        }
    }
}

-(IBAction)startOver
{
    NSInteger i=0;
    while(i<=15)
    {
        [[Tiles objectAtIndex:i] setText:@""];
        i=i+1;
    }
    [self viewDidLoad];
}

-(IBAction)moveLeftButton
{
    [self moveLeft];
}

-(void)moveLeft
{
    int j=0;
    while(j<=14)
    {
        if((j==3) || (j==7) || (j==11))
        {
            NSLog(@"Moving to next Row");
        }
        
        else if([[[Tiles objectAtIndex:j] text] isEqual: [[Tiles objectAtIndex:j+1] text]])
            {
                int sum=[[[Tiles objectAtIndex:j] text] intValue] + [[[Tiles objectAtIndex:j+1] text] intValue];
                if(sum>0)
                {
                    score = score + sum;
                    [[Tiles objectAtIndex:j] setText:[NSString stringWithFormat:@"%d",sum]];
                    [[Tiles objectAtIndex:j+1] setText:@""];
                }
            }
        j=j+1;
        [Score setText:[NSString stringWithFormat:@"%d",score]];
    }
    
    int i=0;
    while(i<=12)
    {
        if([[[Tiles objectAtIndex:i] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+1] text]];
            [[Tiles objectAtIndex:i+1] setText:@""];
        }
        
        if([[[Tiles objectAtIndex:i+1] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+2] text]];
                [[Tiles objectAtIndex:i+2] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i+1] setText: [[Tiles objectAtIndex:i+2] text]];
                [[Tiles objectAtIndex:i+2] setText:@""];
            }
        }
        
        if([[[Tiles objectAtIndex:i+2] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+3] text]];
                [[Tiles objectAtIndex:i+3] setText:@""];
            }
            
            else if([[[Tiles objectAtIndex:i+1] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i+1] setText: [[Tiles objectAtIndex:i+3] text]];
                [[Tiles objectAtIndex:i+3] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i+2] setText: [[Tiles objectAtIndex:i+3] text]];
                [[Tiles objectAtIndex:i+3] setText:@""];
            }
        }
        i=i+4;
    }
    [self randomNumberGenerator];
}

-(IBAction)moveRightButton
{
    [self moveRight];
}

-(void)moveRight
{
    
}

-(IBAction)moveUpButton
{
    [self moveUp];
}

-(void)moveUp
{
    
}

-(IBAction)moveDownButton
{
    [self moveDown];
}

-(void)moveDown
{
    
}

-(IBAction)undo
{
    
}

@end
