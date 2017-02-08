//
//  ViewController.h
//  p02-loya
//
//  Created by Harshad Loya on 2/5/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *Title;

@property (retain, nonatomic) IBOutlet UILabel *Score;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Tiles;


-(IBAction)startOver;
-(IBAction)moveLeftButton;
-(IBAction)moveRightButton;
-(IBAction)moveUpButton;
-(IBAction)moveDownButton;
-(IBAction)undo;

@end

