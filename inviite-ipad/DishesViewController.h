//
//  DishesViewController.h
//  inviite-ipad
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface DishesViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property NSInteger getIntergerValue;
@property (nonatomic , retain) NSArray *getArrayName;
@property (nonatomic , retain) NSArray *ArrayBigImages;
@end
