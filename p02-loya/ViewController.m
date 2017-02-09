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
bool moveUp;
bool moveLeft;
int moveOccurred;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializing the game
    startOfNewGame = true;
    [Score setText:@"0"];
    score=0;
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
    [self tileColorChange];
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
    NSLog(@"Left Button Pressed");
    moveOccurred=0;
    [self moveLeft];
    [self mergingTilesLeftOrRight];
    [self moveLeft];
    [self gameLoseCondn];
    [self gameWinCondn];
    if(moveOccurred==1)
        [self randomNumberGenerator];
    [self tileColorChange];
}

-(void)moveLeft
{
    int i=0;
    while(i<=12)
    {
        if([[[Tiles objectAtIndex:i] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+1] text]];
            [[Tiles objectAtIndex:i+1] setText:@""];
            moveOccurred=1;
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
            moveOccurred=1;
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
            moveOccurred=1;
        }
        i=i+4;
    }
}

-(IBAction)moveRightButton
{
    NSLog(@"Right Button Pressed");
    moveOccurred=0;
    [self moveRight];
    [self mergingTilesLeftOrRight];
    [self moveRight];
    [self gameLoseCondn];
    [self gameWinCondn];
    if(moveOccurred==1)
        [self randomNumberGenerator];
    [self tileColorChange];
}

-(void)moveRight
{
    int i=3;
    while(i<=15)
    {
        if([[[Tiles objectAtIndex:i] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i-1] text]];
            [[Tiles objectAtIndex:i-1] setText:@""];
            moveOccurred=1;
        }
        
        if([[[Tiles objectAtIndex:i-1] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i-2] text]];
                [[Tiles objectAtIndex:i-2] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i-1] setText: [[Tiles objectAtIndex:i-2] text]];
                [[Tiles objectAtIndex:i-2] setText:@""];
            }
            moveOccurred=1;
        }
        
        if([[[Tiles objectAtIndex:i-2] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i-3] text]];
                [[Tiles objectAtIndex:i-3] setText:@""];
            }
            
            else if([[[Tiles objectAtIndex:i-1] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i-1] setText: [[Tiles objectAtIndex:i-3] text]];
                [[Tiles objectAtIndex:i-3] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i-2] setText: [[Tiles objectAtIndex:i-3] text]];
                [[Tiles objectAtIndex:i-3] setText:@""];
            }
            moveOccurred=1;
        }
        i=i+4;
    }
}

-(void)mergingTilesLeftOrRight
{
    int j=0;
    while(j<=14)
    {
        if((j==3) || (j==7) || (j==11))
        {
            //            NSLog(@"Moving to next Row");
        }
        
        else if([[[Tiles objectAtIndex:j] text] intValue] == [[[Tiles objectAtIndex:j+1] text] intValue])
        {
            int sum=[[[Tiles objectAtIndex:j] text] intValue] + [[[Tiles objectAtIndex:j+1] text] intValue];
            if(sum>0)
            {
                score = score + sum;
                if(moveLeft)
                {
                    [[Tiles objectAtIndex:j] setText:[NSString stringWithFormat:@"%d",sum]];
                    [[Tiles objectAtIndex:j+1] setText:@""];
                }
                else
                {
                    [[Tiles objectAtIndex:j+1] setText:[NSString stringWithFormat:@"%d",sum]];
                    [[Tiles objectAtIndex:j] setText:@""];

                }
            }
        }
        j=j+1;
        [Score setText:[NSString stringWithFormat:@"%d",score]];
    }
}

-(IBAction)moveUpButton
{
    NSLog(@"Up Button Pressed");
    moveOccurred=0;
    [self moveUp];
    moveUp = true;
    [self mergingTilesUpOrDown];
    [self moveUp];
    [self gameLoseCondn];
    [self gameWinCondn];
    if(moveOccurred==1)
        [self randomNumberGenerator];
    [self tileColorChange];
}

-(void)moveUp
{
    int i=0;
    while(i<=3)
    {
        if([[[Tiles objectAtIndex:i] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+4] text]];
            [[Tiles objectAtIndex:i+4] setText:@""];
            moveOccurred=1;
        }
        
        if([[[Tiles objectAtIndex:i+4] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+8] text]];
                [[Tiles objectAtIndex:i+8] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i+4] setText: [[Tiles objectAtIndex:i+8] text]];
                [[Tiles objectAtIndex:i+8] setText:@""];
            }
            moveOccurred=1;
        }
        
        if([[[Tiles objectAtIndex:i+8] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i+12] text]];
                [[Tiles objectAtIndex:i+12] setText:@""];
            }
            
            else if([[[Tiles objectAtIndex:i+4] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i+4] setText: [[Tiles objectAtIndex:i+12] text]];
                [[Tiles objectAtIndex:i+12] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i+8] setText: [[Tiles objectAtIndex:i+12] text]];
                [[Tiles objectAtIndex:i+12] setText:@""];
            }
            moveOccurred=1;
        }
        i=i+1;
    }
}

-(IBAction)moveDownButton
{
    NSLog(@"Down Button Pressed");
    moveOccurred=0;
    [self moveDown];
    [self mergingTilesUpOrDown];
    [self moveDown];
    [self gameLoseCondn];
    [self gameWinCondn];
    if(moveOccurred==1)
        [self randomNumberGenerator];
    [self tileColorChange];
}

-(void)moveDown
{
    int i=12;
    while(i<=15)
    {
        if([[[Tiles objectAtIndex:i] text] isEqual:@""])
        {
            [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i-4] text]];
            [[Tiles objectAtIndex:i-4] setText:@""];
            moveOccurred=1;
        }
        
        if([[[Tiles objectAtIndex:i-4] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i-8] text]];
                [[Tiles objectAtIndex:i-8] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i-4] setText: [[Tiles objectAtIndex:i-8] text]];
                [[Tiles objectAtIndex:i-8] setText:@""];
            }
            moveOccurred=1;
        }
        
        if([[[Tiles objectAtIndex:i-8] text] isEqual:@""])
        {
            if([[[Tiles objectAtIndex:i] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i] setText: [[Tiles objectAtIndex:i-12] text]];
                [[Tiles objectAtIndex:i-12] setText:@""];
            }
            
            else if([[[Tiles objectAtIndex:i-4] text] isEqual:@""])
            {
                [[Tiles objectAtIndex:i-4] setText: [[Tiles objectAtIndex:i-12] text]];
                [[Tiles objectAtIndex:i-12] setText:@""];
            }
            else
            {
                [[Tiles objectAtIndex:i-8] setText: [[Tiles objectAtIndex:i-12] text]];
                [[Tiles objectAtIndex:i-12] setText:@""];
            }
            moveOccurred=1;
        }
        i=i+1;
    }
}

-(void)mergingTilesUpOrDown
{
    int j=0;
    while(j<=11)
    {
        if([[[Tiles objectAtIndex:j] text] intValue] == [[[Tiles objectAtIndex:j+4] text] intValue])
        {
            int sum=[[[Tiles objectAtIndex:j] text] intValue] + [[[Tiles objectAtIndex:j+4] text] intValue];
            if(sum>0)
            {
                score = score + sum;
                if (moveUp)
                {
                    [[Tiles objectAtIndex:j] setText:[NSString stringWithFormat:@"%d",sum]];
                    [[Tiles objectAtIndex:j+4] setText:@""];
                    moveUp = false;
                }
                else
                {
                    [[Tiles objectAtIndex:j+4] setText:[NSString stringWithFormat:@"%d",sum]];
                    [[Tiles objectAtIndex:j] setText:@""];
                }
            }
        }
        j=j+1;
        [Score setText:[NSString stringWithFormat:@"%d",score]];
    }
}

-(void)tileColorChange
{
    /*
     RGB values taken from http://scrambledeggsontoast.github.io/2014/05/09/writing-2048-elm/
    */
    for (int i=0; i<=15; i++) {
        switch([[[Tiles objectAtIndex:i] text] intValue])
        {
            case 2:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:228.0f/255.0f blue:218.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pm.jpg"]]];
                break;
            case 4:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:224.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ms.jpg"]]];
                break;
            case 8:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:242.0f/255.0f green:177.0f/255.0f blue:121.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"kd.jpg"]]];
                break;
            case 16:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:149.0f/255.0f blue:99.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"kg.jpg"]]];
                break;
            case 32:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:246.0f/255.0f green:124.0f/255.0f blue:95.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wm.jpg"]]];
                break;
            case 64:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:246.0f/255.0f green:94.0f/255.0f blue:59.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sm.jpg"]]];
                break;
            case 128:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:207.0f/255.0f blue:114.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"zz.jpg"]]];
                break;
            case 256:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:204.0f/255.0f blue:97.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"kc.jpg"]]];
                break;
            case 512:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:200.0f/255.0f blue:80.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ll.jpg"]]];
                break;
            case 1024:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:197.0f/255.0f blue:63.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mg.jpg"]]];
                break;
            case 2048:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:194.0f/255.0f blue:46.0f/255.0f alpha:1.0f]];
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"harvey.jpg"]]];
                break;
            default:
                [[Tiles objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
                break;
        }
    }
}

-(void)gameWinCondn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Won" message:@"Congrats!!! You did it. Press Reset to play again." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK Selected");
                                   }];
    [alertController addAction:okAction];
    
    
    for (int i=0; i<=15; i++) {
        if([[[Tiles objectAtIndex:i] text] intValue] == 2048)
            [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)gameLoseCondn
{
    int x=0;
    bool canPlayMore = false;
    for (x=0; x<=15; x++) {
        if([[[Tiles objectAtIndex:x] text] isEqualToString:@""])
        {
            //NSLog(@"Empty Tile available");
            canPlayMore = true;
        }
        else
        {
            if ((x==3) || (x==7) || (x==11) )
            {
                if([[[Tiles objectAtIndex:x] text] intValue] == [[[Tiles objectAtIndex:x+4] text] intValue])
                {
                    canPlayMore = true;
                }
            }
            else if(x<=10)
            {
                if([[[Tiles objectAtIndex:x] text] intValue] == [[[Tiles objectAtIndex:x+4] text] intValue])
                {
                    canPlayMore = true;
                }
                else if([[[Tiles objectAtIndex:x] text] intValue] == [[[Tiles objectAtIndex:x+1] text] intValue])
                {
                    canPlayMore = true;
                }
            }
            else
            {
                if((x!=15)&&[[[Tiles objectAtIndex:x] text] intValue] == [[[Tiles objectAtIndex:x+1] text] intValue])
                {
                    canPlayMore = true;
                }
            }
        }
        if (canPlayMore) {
            break;
        }
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"Sorry, no more moves available, You LOST!!! Press Reset to play again." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK Selected");
                               }];
    [alertController addAction:okAction];
    
    if (canPlayMore==false) {
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(IBAction)undo
{
    
}

@end
