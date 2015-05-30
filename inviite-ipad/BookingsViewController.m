//
//  ViewController.m
//  inviite-ipad
//
//  Created by Mac on 5/5/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "BookingsViewController.h"
#import "BookingsCell.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "MasterViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
@interface BookingsViewController ()

@property (nonatomic) BOOL blurred;

@end

@implementation BookingsViewController
@synthesize bookingsTableView,numberOfselected,bookings,selectedBookings,plansLabel,multipleConfirmButton,multipleDeclineButton,leftSideView,menuTableView;
@synthesize view_myVenu;
@synthesize tbl_myVenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    bookingsTableView.delegate = self;
    bookingsTableView.dataSource = self;
    bookingsTableView.backgroundColor = [UIColor clearColor];
    bookingsTableView.allowsSelection = NO;
    
    //navigation options
    ary=[[NSArray alloc]initWithObjects:@"Homepage",@"Analytica & Trends",@"Promotions",@"Guestlist",@"Menu",@"user & Roles", @"My Venues" ,nil];
    UIImageView* customView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 22)];
    UIImageView* customView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc]initWithCustomView:customView];
    customView.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc]initWithCustomView:customView2];
    customView2.image = [UIImage imageNamed:@"menu"];
    self.navigationItem.rightBarButtonItem = menuButton;
    UITapGestureRecognizer* menuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    menuTap.delegate = self;
    [customView2 addGestureRecognizer:menuTap];

    
    UITapGestureRecognizer* backtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
    backtap.delegate = self;
    [customView addGestureRecognizer:backtap];
    
     numberOfselected = 0;
    [self reloadMultipleSelection];
      self.menuTableView.hidden=YES;
   
    
    self.menuTableView.translatesAutoresizingMaskIntoConstraints=YES;
    self.menuTableView.frame=CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width/3 , self.view.frame.size.height);
    self.menuTableView.userInteractionEnabled=YES;
    [self getPlan];

    [bookingsTableView reloadData];

}
-(void)getBookings
{
    
    
    
    
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSString *string=[NSString stringWithFormat:@"Bearer %@",token];
    
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
   
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   
    
    
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://inviiteapp.jerrardwayne.net/bookings" parameters:nil error:NULL];
    
    // Add Headers
    [request setValue:@"application/vnd.inviite.v1+json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:string forHTTPHeaderField:@"Authorization"];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject)
                                         {
                                             //   [SVProgressHUD dismiss];
                                             
                                             NSLog(@"HTTP Response Status Code: %ld", (long)[operation.response statusCode]);
                                            
                                             NSMutableArray* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                                  options:kNilOptions error:nil];
                                              NSLog(@"HTTP Response Body: %@", json);
                                         }
                                         
                                         
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             //    [SVProgressHUD dismiss];
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
    [self getPlan];
}

-(void)getPlan
{
//http://inviiteapp.jerrardwayne.net/bookings?include=venue,plan

    plans=[[NSMutableArray alloc]init];
    
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSString *string=[NSString stringWithFormat:@"Bearer %@",token];
    
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://inviiteapp.jerrardwayne.net/bookings?include=venue,plan" parameters:nil error:NULL];
    
    // Add Headers
    [request setValue:@"application/vnd.inviite.v1+json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:string forHTTPHeaderField:@"Authorization"];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject)
                                         {
                                             //   [SVProgressHUD dismiss];
                                             
                                             NSLog(@"HTTP Response Status Code: %ld", (long)[operation.response statusCode]);
                                             
                                          plans = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                                    options:kNilOptions error:nil];
                                             NSLog(@"plans-----%@", [plans  valueForKey:@"data"]);
                                         }
                                         
                                         
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             //    [SVProgressHUD dismiss];
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];

}
-(void)backTap:(id)sender
{
    
    
  
    
    
  //  [self.navigationController pushViewController:vc animated:NO];
    
    
    
}
-(void)showMenu:(id)sender{
    NSLog(@"Yo");
    if ([self.menuTableView isHidden])
    {
         [self.view bringSubviewToFront:self.menuTableView];
        [self.menuTableView reloadData];
        self.menuTableView.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.menuTableView.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/3, 0,self.view.frame.size.width/3 , self.view.frame.size.height);
           
        }];
        
    }
    else
    {
        
        [UIView animateWithDuration:0.3 animations:^{
              self.menuTableView.frame=CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width/3 , self.view.frame.size.height);
        } completion:^(BOOL finished) {
            [self.menuTableView setHidden:YES];
        }];

    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    
    if (token == nil) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
    {
        NSLog(@"%@",token);
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //top
  /*  if ([self.view viewWithTag:10] == nil) {
        UIView* bookingsInboxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50.0)];
        bookingsInboxView.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:0.95];
        [self.view addSubview:bookingsInboxView];
        UILabel* bookingsInboxL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, bookingsInboxView.frame.size.height)];
        bookingsInboxL.textColor = [UIColor whiteColor];
        bookingsInboxL.textAlignment = NSTextAlignmentCenter;
        bookingsInboxL.font = [UIFont boldSystemFontOfSize:17.0];
        bookingsInboxL.text = @"Bookings Inbox";
        [bookingsInboxView addSubview:bookingsInboxL];
       
       
        
        
        
        
        
        UIView* navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, bookingsInboxView.frame.origin.y + bookingsInboxView.frame.size.height, self.view.frame.size.width, 68.5)];
        navigationView.tag = 10;
        navigationView.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:0.3];
        [self.view addSubview:navigationView];
        
        UILabel* admin = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 100, 100)];
        admin.numberOfLines = 2;
        admin.textAlignment = NSTextAlignmentCenter;
        admin.textColor = [UIColor whiteColor];
        admin.text = @"Admin\nProfile";
        [navigationView addSubview:admin];
        
        UILabel* date = [[UILabel alloc]initWithFrame:CGRectMake(admin.frame.origin.x + 125, 0, 100, 100)];
        date.numberOfLines = 2;
        date.textAlignment = NSTextAlignmentCenter;
        date.textColor = [UIColor whiteColor];
        date.text = @"Date & Time\nSent";
        [navigationView addSubview:date];
        
        UILabel* bookingDate = [[UILabel alloc]initWithFrame:CGRectMake(date.frame.origin.x + 100, 0, 100, 100)];
        bookingDate.numberOfLines = 2;
        bookingDate.textAlignment = NSTextAlignmentCenter;
        bookingDate.textColor = [UIColor whiteColor];
        bookingDate.text = @"Admin\nProfile";
        [navigationView addSubview:bookingDate];
        
        UILabel* numberOfGuests = [[UILabel alloc]initWithFrame:CGRectMake(bookingDate.frame.origin.x + 100, 0, 100, 100)];
        numberOfGuests.numberOfLines = 2;
        numberOfGuests.textAlignment = NSTextAlignmentCenter;
        numberOfGuests.textColor = [UIColor whiteColor];
        numberOfGuests.text = @"Number\nof Guests";
        [navigationView addSubview:numberOfGuests];
        
        UILabel* guestDetails = [[UILabel alloc]initWithFrame:CGRectMake(numberOfGuests.frame.origin.x + 90, 0, 150, 100)];
        guestDetails.numberOfLines = 2;
        guestDetails.textAlignment = NSTextAlignmentCenter;
        guestDetails.textColor = [UIColor whiteColor];
        guestDetails.text = @"Guest Details\n(Male:Female)";
        [navigationView addSubview:guestDetails];
        
        UILabel* ageRange = [[UILabel alloc]initWithFrame:CGRectMake(guestDetails.frame.origin.x + 130, 0, 100, 100)];
        ageRange.numberOfLines = 1;
        ageRange.textAlignment = NSTextAlignmentCenter;
        ageRange.textColor = [UIColor whiteColor];
        ageRange.text = @"Age Range";
        [navigationView addSubview:ageRange];
        
        UILabel* buttonsL = [[UILabel alloc]initWithFrame:CGRectMake(ageRange.frame.origin.x + 100, 0, 200, 100)];
        buttonsL.numberOfLines = 1;
        buttonsL.textAlignment = NSTextAlignmentCenter;
        buttonsL.textColor = [UIColor whiteColor];
        buttonsL.text = @"Quick Decline/Confirm";
        [navigationView addSubview:buttonsL];
        
        //checkin
        UIButton* checkinButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 350, 10, 150, 30)];
        [checkinButton setImage:[UIImage imageNamed:@"CheckIn"] forState:UIControlStateNormal];
        [checkinButton setTitle:@" Check in" forState:UIControlStateNormal];
        [checkinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.navigationController.navigationBar addSubview:checkinButton];
    //    [[[UIApplication sharedApplication].keyWindow addSubview:self.menuTableView];
         [self.view bringSubviewToFront:self.menuTableView];
    }
    */
   

}

#pragma mark TableView mathods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.menuTableView) {
        return 7;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"cell";
      BookingsCell *cell = (BookingsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(tableView == bookingsTableView)
    {
        if(cell == nil)
        {
            cell = [[BookingsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:0.5];
        }else{
            cell.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:0.7];
        }
        
        
        
        [cell.checkButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
        [cell.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [cell.declineButton addTarget:self action:@selector(decline:) forControlEvents:UIControlEventTouchUpInside];
    }else if (tableView == menuTableView)
    {
        
            
            UITableViewCell *cell2 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell2 == nil)
            {
                cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            }
            
            cell2.backgroundColor=[UIColor clearColor];
            
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 84, self.menuTableView.frame.size.width, 0.5)];
            lable.backgroundColor=[UIColor grayColor];
            [cell2.contentView  addSubview:lable];
            self.menuTableView.backgroundColor= [UIColor colorWithRed:(221/255.f) green:(221/255.f) blue:(221/255.f) alpha:1.0f];
            cell2.textLabel.text=[ary objectAtIndex:indexPath.row];
            return cell2;
    
        
        
       
    }else if (tableView == tbl_myVenu)
    {
        if(cell == nil)
        {
            cell = [[BookingsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:0.5];
        }else{
            cell.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:0.7];
        }
        
       
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 15, 100, 20)];
        fromLabel.text = @"dsfsd";
        fromLabel.numberOfLines = 1;
        [cell addSubview:fromLabel];
    }
    

    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView==self.menuTableView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
        [headerView setBackgroundColor:[UIColor colorWithRed:(71/255.f) green:(74/255.f) blue:(82/255.f) alpha:1.0f]];
        ;
        UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        textLabel.text = @"The Keys-Yarm";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor=[UIColor whiteColor];
        [textLabel  setFont:[UIFont systemFontOfSize:18]];
        [headerView addSubview:textLabel];
        
        
        return headerView;

    }else if (tableView == tbl_myVenu  || tableView==self.bookingsTableView)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
        [headerView setBackgroundColor:[UIColor colorWithRed:(71/255.f) green:(74/255.f) blue:(82/255.f) alpha:1.0f]];
        
        ;
        
        
        UILabel* admin = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 100, 50)];
        admin.numberOfLines = 2;
        admin.textAlignment = NSTextAlignmentCenter;
        admin.textColor = [UIColor whiteColor];
        admin.text = @"Admin\nProfile";
        [headerView addSubview:admin];
        
        UILabel* date = [[UILabel alloc]initWithFrame:CGRectMake(admin.frame.origin.x + 125, 0, 100, 50)];
        date.numberOfLines = 2;
        date.textAlignment = NSTextAlignmentCenter;
        date.textColor = [UIColor whiteColor];
        date.text = @"Date & Time\nSent";
        [headerView addSubview:date];
        
        UILabel* bookingDate = [[UILabel alloc]initWithFrame:CGRectMake(date.frame.origin.x + 100, 0, 100, 50)];
        bookingDate.numberOfLines = 2;
        bookingDate.textAlignment = NSTextAlignmentCenter;
        bookingDate.textColor = [UIColor whiteColor];
        bookingDate.text = @"Admin\nProfile";
        [headerView addSubview:bookingDate];
        
        UILabel* numberOfGuests = [[UILabel alloc]initWithFrame:CGRectMake(bookingDate.frame.origin.x + 100, 0, 100, 50)];
        numberOfGuests.numberOfLines = 2;
        numberOfGuests.textAlignment = NSTextAlignmentCenter;
        numberOfGuests.textColor = [UIColor whiteColor];
        numberOfGuests.text = @"Number\nof Guests";
        [headerView addSubview:numberOfGuests];
        
        UILabel* guestDetails = [[UILabel alloc]initWithFrame:CGRectMake(numberOfGuests.frame.origin.x + 90, 0, 150, 50)];
        guestDetails.numberOfLines = 2;
        guestDetails.textAlignment = NSTextAlignmentCenter;
        guestDetails.textColor = [UIColor whiteColor];
        guestDetails.text = @"Guest Details\n(Male:Female)";
        [headerView addSubview:guestDetails];
        
        UILabel* ageRange = [[UILabel alloc]initWithFrame:CGRectMake(guestDetails.frame.origin.x + 130, 0, 100, 50)];
        ageRange.numberOfLines = 1;
        ageRange.textAlignment = NSTextAlignmentCenter;
        ageRange.textColor = [UIColor whiteColor];
        ageRange.text = @"Age Range";
        [headerView addSubview:ageRange];
        
        UILabel* buttonsL = [[UILabel alloc]initWithFrame:CGRectMake(ageRange.frame.origin.x + 100, 0, 200, 50)];
        buttonsL.numberOfLines = 1;
        buttonsL.textAlignment = NSTextAlignmentCenter;
        buttonsL.textColor = [UIColor whiteColor];
        buttonsL.text = @"Quick Decline/Confirm";
        [headerView addSubview:buttonsL];
        
        
        return headerView;
    }
    
    return nil;
   }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.bookingsTableView || tableView == tbl_myVenu) {
        
        return 50;
    }else if (tableView ==self.menuTableView)
    {
        return 50;
    }
    
    return 0;
}
-(void)confirm:(UIButton*)sender{
    UITableViewCell* cell = (UITableViewCell*)sender.superview;
    NSLog(@"%ld",(long)[bookingsTableView indexPathForCell:cell].row);
    //initialising leftSideView
    leftSideView = [[UIView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width / 3, 0, self.view.frame.size.width / 3, self.view.frame.size.height)];
    leftSideView.backgroundColor = [UIColor lightGrayColor];
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, leftSideView.frame.size.width, 50)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.text = @"Plan Details - Birthday Beers";
    [leftSideView addSubview:titleLabel];
    UIView* borderV = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + 50, leftSideView.frame.size.width, 1.0)];
    borderV.backgroundColor = [UIColor blackColor];
    [leftSideView addSubview:borderV];
    UIImageView* profileImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, borderV.frame.origin.y + 20, 40, 40)];
    profileImage.image = [UIImage imageNamed:@"profile_image"];
    profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
    profileImage.layer.masksToBounds = YES;
    [leftSideView addSubview:profileImage];
    UIImageView* timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(profileImage.frame.origin.x + 60, profileImage.frame.origin.y + 15, 20, 20)];
    timeImage.image = [UIImage imageNamed:@"timeIcon"];
    [leftSideView addSubview:timeImage];
    UIImageView* dateImage = [[UIImageView alloc]initWithFrame:CGRectMake(profileImage.frame.origin.x + 60, profileImage.frame.origin.y + 55, 20, 20)];
    dateImage.image = [UIImage imageNamed:@"dateIcon"];
    [leftSideView addSubview:dateImage];
    UILabel* timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.frame.origin.x + 40, timeImage.frame.origin.y, 50, 30)];
    timeLabel.text = @"18:00";
    [leftSideView addSubview:timeLabel];
    UILabel* dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(dateImage.frame.origin.x + 40, dateImage.frame.origin.y, 50, 30)];
    dateLabel.text = @"23/05";
    [leftSideView addSubview:dateLabel];
    UILabel* nameList = [[UILabel alloc]initWithFrame:CGRectMake(10, profileImage.frame.origin.y + 40, 40, 30)];
    nameList.text = @"Name";
    [leftSideView addSubview:nameList];
    UILabel* mfList = [[UILabel alloc]initWithFrame:CGRectMake(nameList.frame.origin.x + 60, profileImage.frame.origin.y + 40, 40, 30)];
    mfList.text = @"M/F";
    [leftSideView addSubview:mfList];
    UILabel* ageList = [[UILabel alloc]initWithFrame:CGRectMake(mfList.frame.origin.x + 60, profileImage.frame.origin.y + 40, 40, 30)];
    ageList.text = @"Age";
    [leftSideView addSubview:ageList];
    UILabel* nameListDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, nameList.frame.origin.y + 20, 100, 100)];
    nameListDetail.text = @"Name 1\nName 2\nName 3";
    nameListDetail.numberOfLines = 0;
    [leftSideView addSubview:nameListDetail];
    UILabel* mfListDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, mfList.frame.origin.y + 20, 100, 100)];
    mfListDetail.text = @"Male 1\nFemale 2\nMale 3";
    mfListDetail.numberOfLines = 0;
    [leftSideView addSubview:mfListDetail];
    UILabel* ageListDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, ageList.frame.origin.y + 20, 100, 100)];
    ageListDetail.text = @"18\n22\n23";
    ageListDetail.numberOfLines = 0;
    [leftSideView addSubview:ageListDetail];
    UIView* borderV2 = [[UIView alloc]initWithFrame:CGRectMake(0, ageListDetail.frame.origin.y + 50, leftSideView.frame.size.width, 1.0)];
    borderV2.backgroundColor = [UIColor blackColor];
    [leftSideView addSubview:borderV2];
    UILabel* optionsL = [[UILabel alloc]initWithFrame:CGRectMake(20, borderV2.frame.origin.y+30, 100, 30)];
    optionsL.text = @"Decline plan";
    [leftSideView addSubview:optionsL];
    UITextField* optionsField = [[UITextField alloc]initWithFrame:CGRectMake(20, optionsL.frame.origin.y + 20, leftSideView.frame.size.width - 40, 60)];
    optionsField.backgroundColor = [UIColor lightGrayColor];
    [leftSideView addSubview:optionsField];
    UIButton* sendButton = [[UIButton alloc]initWithFrame:CGRectMake(50, optionsField.frame.origin.y + 20, 50, 20)];
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor darkGrayColor];
    sendButton.layer.cornerRadius = 20.f;
    [sendButton addTarget:self action:@selector(sendResponse:) forControlEvents:UIControlEventTouchUpInside];
    [leftSideView addSubview:sendButton];
    
    
    
    [self.view addSubview:leftSideView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.leftSideView.frame=CGRectMake(0, 0, self.view.frame.size.width / 3, self.view.frame.size.height);
        
    }];
    

}
-(void)check:(UIButton*)sender{
    UITableViewCell* cell = (UITableViewCell*)sender.superview;
    NSLog(@"%ld",(long)[bookingsTableView indexPathForCell:cell].row);
    NSLog(@"%lu",(unsigned long)sender.state);
    if (sender.state == 1) {
        sender.selected = YES;
        numberOfselected = [NSNumber numberWithInt:numberOfselected.intValue + 1];
        [self reloadMultipleSelection];
    }else if (sender.state == 5){
        sender.selected = NO;
        numberOfselected = [NSNumber numberWithInt:numberOfselected.intValue - 1];
        [self reloadMultipleSelection];
    }
}

-(void)sendResponse:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        
       self.leftSideView.frame= CGRectMake(-self.view.frame.size.width / 3, 0, self.view.frame.size.width / 3, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        [leftSideView removeFromSuperview];
    }];
}

-(void)decline:(UIButton*)sender{
    UITableViewCell* cell = (UITableViewCell*)sender.superview;
    NSLog(@"%ld",(long)[bookingsTableView indexPathForCell:cell].row);
}

-(void)reloadMultipleSelection{
    if (numberOfselected.intValue <= 1)
    {
        plansLabel.hidden = YES;
        multipleDeclineButton.hidden = YES;
        multipleConfirmButton.hidden = YES;
    }
    else
    {
        plansLabel.hidden = NO;
        plansLabel.text = [NSString stringWithFormat:@"%@ Plans Selected",numberOfselected];
        multipleDeclineButton.hidden = NO;
        multipleConfirmButton.hidden = NO;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == menuTableView)
    {
        if (indexPath.row==0) {
             tbl_myVenu.hidden=YES;
            bookingsTableView.hidden=NO;
        }
        else if (indexPath.row == 6)
        {
            tbl_myVenu.hidden=NO;
            [tbl_myVenu reloadData];
            bookingsTableView.hidden=YES;
            
        }
        if (indexPath.row==4) {
            MasterViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"master"];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
            
            
            DetailViewController * vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
            UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:vc2];
            
            AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            UISplitViewController *svc = (UISplitViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SplitView"];
            appdelegate.window.rootViewController=svc;
            // svc.viewControllers=[NSArray arrayWithObjects:nav,nav2, nil];
            [self.navigationController pushViewController:svc animated:NO];
            
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.menuTableView.frame=CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width/3 , self.view.frame.size.height);
        } completion:^(BOOL finished) {
            [self.menuTableView setHidden:YES];
        }];
    
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
