//
//  ViewController.h
//  p02-loya
//
//  Created by Harshad Loya on 2/5/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{

    IBOutlet UILabel *title;
    
    IBOutlet UILabel *score;
    
    IBOutletCollection(UILabel) NSArray *tiles;
}


@end

