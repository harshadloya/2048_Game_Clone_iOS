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

@property (strong, nonatomic) IBOutlet UILabel *Score;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Tiles;

@property (strong, nonatomic) IBOutlet UIButton *Reset;


@end

