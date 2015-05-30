//
//  ViewController.h
//  inviite-ipad
//
//  Created by Mac on 5/5/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,NSURLConnectionDelegate>
{
    NSArray *ary;
    NSMutableArray *plans;
}
@property (weak, nonatomic) IBOutlet UITableView *bookingsTableView;
@property (strong,nonatomic) NSNumber* numberOfselected;
@property (strong, nonatomic) NSDictionary* bookings;
@property (strong,nonatomic) NSDictionary* selectedBookings;
@property (weak, nonatomic) IBOutlet UILabel *plansLabel;
@property (weak, nonatomic) IBOutlet UIButton *multipleConfirmButton;
@property (weak, nonatomic) IBOutlet UIButton *multipleDeclineButton;
@property (strong, nonatomic) UIView *leftSideView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIView *view_myVenu;
@property (strong, nonatomic) IBOutlet UITableView *tbl_myVenu;
@end

