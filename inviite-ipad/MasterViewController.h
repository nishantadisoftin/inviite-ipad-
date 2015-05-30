//
//  MasterViewController.h
//  tablet
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class DishesViewController;

@interface MasterViewController : UITableViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) DishesViewController *dishViewController;
@property (nonatomic,retain) NSArray *aryMenu;
@property (nonatomic,retain) NSArray *subMenu;
@property (nonatomic,retain) NSMutableArray *aryAllData;






@end

