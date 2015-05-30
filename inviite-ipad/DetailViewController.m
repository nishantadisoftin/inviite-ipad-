//
//  DetailViewController.m
//  tablet
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "DetailViewController.h"
#import "BookingsViewController.h"
#import "AppDelegate.h"
@interface DetailViewController ()

@property (nonatomic) CGPoint previousTranslation;

@end

@implementation DetailViewController
@synthesize getArrayImages,getArrayName;
@synthesize _collectionView;
@synthesize getIntergerValue,ArrayBigImages;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    gesture.delegate = self;
    [self.detailItemDescription addGestureRecognizer:gesture];
    [gesture setMaximumNumberOfTouches:1];
    [gesture setMinimumNumberOfTouches:1];
    
    getArrayName=[NSArray arrayWithObjects:@"Bellini",
             @"Cosmopolitan", @"Martini", @"Negroni",
                  @"Old Fashioned", @"Mojito", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
     ary=[[NSArray alloc]initWithObjects:@"Homepage",@"Analytica & Trends",@"Promotions",@"Guestlist",@"Menu",@"user & Roles", @"My Venues" ,nil];
    
    getArrayImages=[NSArray arrayWithObjects:@"bellini-thumb.png",
                  @"cosmopolitan-thumb.png", @"martini-thumb.png", @"mojito-thumb.png",
                  @"negroni-thumb.png", @"oldFashionedi-thumb.png", nil];
    
    ArrayBigImages=[NSArray arrayWithObjects:@"bellini.jpg",
                    @"cosmopolitan.jpg", @"martini.jpg", @"mojito.jpg",
                    @"negroni.jpg", @"oldFashioned.jpg", nil];
    
    
    self.menuTableView.hidden=YES;
    UIImageView* customView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc]initWithCustomView:customView2];
    customView2.image = [UIImage imageNamed:@"menu"];
    self.navigationItem.rightBarButtonItem = menuButton;
    UITapGestureRecognizer* menuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    menuTap.delegate = self;
    [customView2 addGestureRecognizer:menuTap];
    
    
    UILabel* bookingsInboxL2 = [[UILabel alloc]initWithFrame:CGRectMake(20
                                                                        , 7, self.view.frame.size.width, 30)];
    bookingsInboxL2.textColor = [UIColor whiteColor];
    bookingsInboxL2.textAlignment = NSTextAlignmentCenter;
    bookingsInboxL2.font = [UIFont boldSystemFontOfSize:14.0];
    bookingsInboxL2.text = @"Ad New Item";
    
    [self.navigationController.navigationBar addSubview:bookingsInboxL2];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(590, 12, 20, 20)];
    img.image=[UIImage imageNamed:@"plus"];
    
    [self.navigationController.navigationBar addSubview:img];
    
    
    
    
    self.menuTableView.translatesAutoresizingMaskIntoConstraints=YES;
    self.menuTableView.frame=CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width/2 , self.view.frame.size.height);

    [self configureView];
    
    }

-(void)handlePan:(UIPanGestureRecognizer*)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(getIntergerValue ==0)
     return 6;
    else if (getIntergerValue == 1)
        return 1;
    else if (getIntergerValue == 2)
        return 4;
    else if (getIntergerValue == 3)
        return 2;
    else if (getIntergerValue == 4)
        return 5;
    else if (getIntergerValue == 5)
        return 3;
    else
        return 6;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    //....1
    UIView* view_collection = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 190, 220)];
    [view_collection setBackgroundColor: [UIColor colorWithRed:67/255.0 green:69/255.0 blue:74/255.0 alpha:1]];
    
    
    //.....2
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(10,10,170,150)];
    dot.image=[UIImage imageNamed:[getArrayImages objectAtIndex:indexPath.row ]];
   // dot.backgroundColor=[UIColor redColor];
    [view_collection addSubview:dot];
    
    //.....3
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,174 , 170, 40)];
    fromLabel.backgroundColor=[UIColor clearColor];
    fromLabel.text = [getArrayName objectAtIndex:indexPath.row];
    fromLabel.font = [UIFont fontWithName:@"" size:12]; //custom font
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = YES;
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.textColor=[UIColor whiteColor];
    [view_collection addSubview:fromLabel];
    
    [cell addSubview: view_collection];
    
   // cell.backgroundColor=[UIColor colorWithRed:67/255.0 green:69/255.0 blue:74/255.0 alpha:0.75];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(190, 250);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_collectionView removeFromSuperview];
    [self.detailItemDescription removeFromSuperview];
    self.detailItemDescription = [[UIScrollView alloc]initWithFrame:CGRectMake(60, 40, 580,664)];
    self.detailItemDescription.backgroundColor = [UIColor clearColor];
    
    [self.detailItemDescription setShowsHorizontalScrollIndicator:NO];
    [self.detailItemDescription setShowsVerticalScrollIndicator:NO];
    
    // ...... 1 Top image
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,580,600)];
    dot.image=[UIImage imageNamed:[ArrayBigImages objectAtIndex:indexPath.row]];
    dot.backgroundColor=[UIColor clearColor];
    [self.detailItemDescription addSubview:dot];
    
    //...... add second view
    UIView* view_collection = [[UIView alloc] initWithFrame: CGRectMake(0, 600, 580, 500)];
    [view_collection setBackgroundColor: [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]];
    
    // .... Create down view Description
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(50,50 , 170, 20)];
    fromLabel.backgroundColor=[UIColor clearColor];
    fromLabel.text = @"Description";
    fromLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18]; //custom font
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = YES;
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.textColor=[UIColor blackColor];
    [view_collection addSubview:fromLabel];
    
    UILabel *Label_desdata = [[UILabel alloc]initWithFrame:CGRectMake(50,70 , 500 , 80)];
    Label_desdata.backgroundColor=[UIColor clearColor];
    Label_desdata.text = @"dffdsfsd dsf sdfds sdfds fds fdsf dsf sdfsdf sdfds f dsfdsfdsf dsf sdfdsfdsf sdf sdfsdfsdfsdfsdf sdfsdf sdfsdfsdfsd fds f sdf sdfsd fsdf sdf s";
    Label_desdata.font = [UIFont fontWithName:@"System" size:13]; //custom font
    Label_desdata.numberOfLines = 10;
    Label_desdata.baselineAdjustment = YES;
    Label_desdata.adjustsFontSizeToFitWidth = YES;
    Label_desdata.textColor=[UIColor blackColor];
    [view_collection addSubview:Label_desdata];
    
    
    // .... Create down view Ingredients
    UILabel *fromLabel_ini = [[UILabel alloc]initWithFrame:CGRectMake(50,150 , 170, 20)];
    fromLabel_ini.backgroundColor=[UIColor clearColor];
    fromLabel_ini.text = @"Ingredients";
    fromLabel_ini.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18]; //custom font
    fromLabel_ini.numberOfLines = 1;
    fromLabel_ini.baselineAdjustment = YES;
    fromLabel_ini.adjustsFontSizeToFitWidth = YES;
    fromLabel_ini.textColor=[UIColor blackColor];
    [view_collection addSubview:fromLabel_ini];
    
    UILabel *Label_desdata_ini = [[UILabel alloc]initWithFrame:CGRectMake(50,170 , 500 , 80)];
    Label_desdata_ini.backgroundColor=[UIColor clearColor];
    Label_desdata_ini.text = @"dffdsfsd dsf sdfds sdfds fds fdsf dsf sdfsdf sdfds f dsfdsfdsf dsf sdfdsfdsf sdf sdfsdfsdfsdfsdf sdfsdf sdfsdfsdfsd fds f sdf sdfsd fsdf sdf s";
    Label_desdata_ini.font = [UIFont fontWithName:@"System" size:13]; //custom font
    Label_desdata_ini.numberOfLines = 10;
    Label_desdata_ini.baselineAdjustment = YES;
    Label_desdata_ini.adjustsFontSizeToFitWidth = YES;
    Label_desdata_ini.textColor=[UIColor blackColor];
    [view_collection addSubview:Label_desdata_ini];
    
    // .... Create down view Ingredients
    UILabel *fromLabel_allergy = [[UILabel alloc]initWithFrame:CGRectMake(50,250 , 170, 20)];
    fromLabel_allergy.backgroundColor=[UIColor clearColor];
    fromLabel_allergy.text = @"Allergy Alerts";
    fromLabel_allergy.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18]; //custom font
    fromLabel_allergy.numberOfLines = 1;
    fromLabel_allergy.baselineAdjustment = YES;
    fromLabel_allergy.adjustsFontSizeToFitWidth = YES;
    fromLabel_allergy.textColor=[UIColor blackColor];
    [view_collection addSubview:fromLabel_allergy];
    
    //.......................... images set ..................................
    
    UIImageView *img1 =[[UIImageView alloc] initWithFrame:CGRectMake(50,300,41,41)];
    img1.image=[UIImage imageNamed:@"meat-icon.png"];
    [view_collection addSubview:img1];
    
    UIImageView *img2 =[[UIImageView alloc] initWithFrame:CGRectMake(160,300,41,41)];
    img2.image=[UIImage imageNamed:@"poultry.png"];
    [view_collection addSubview:img2];
    
    UIImageView *img3 =[[UIImageView alloc] initWithFrame:CGRectMake(280,300,41,41)];
    img3.image=[UIImage imageNamed:@"garlic.png"];
    [view_collection addSubview:img3];
    
    UIImageView *img4 =[[UIImageView alloc] initWithFrame:CGRectMake(400,300,41,41)];
    img4.image=[UIImage imageNamed:@"crustaceans.png"];
    [view_collection addSubview:img4];
    
    UIImageView *img5 =[[UIImageView alloc] initWithFrame:CGRectMake(500,300,41,41)];
    img5.image=[UIImage imageNamed:@"fish.png"];
    [view_collection addSubview:img5];
    
    
    ///...................label .....................
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(50,350 , 41, 15)];
    lbl1.text =@"Meat";
    lbl1.textAlignment=NSTextAlignmentCenter;
    [lbl1 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(160,350 , 41, 15)];
    lbl2.text =@"Poultry";
    lbl2.textAlignment=NSTextAlignmentCenter;
    [lbl2 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl2];
    
    UILabel *lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(280,350 , 41, 15)];
    lbl3.text =@"Garlic";
    lbl3.textAlignment=NSTextAlignmentCenter;
    [lbl3 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl3];
    
    UILabel *lbl4 = [[UILabel alloc]initWithFrame:CGRectMake(390,350 , 70, 15)];
    lbl4.text =@"Crustaceans";
    lbl4.textAlignment=NSTextAlignmentCenter;
    [lbl4 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl4];
    
    UILabel *lbl5 = [[UILabel alloc]initWithFrame:CGRectMake(500,350 , 41, 15)];
    lbl5.text =@"Fish";
    lbl5.textAlignment=NSTextAlignmentCenter;
    [lbl5 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl5];
    
    // Second Rows for images
    UIImageView *img6 =[[UIImageView alloc] initWithFrame:CGRectMake(50,400,41,41)];
    img6.image=[UIImage imageNamed:@"gluten.png"];
    [view_collection addSubview:img6];
    
    UIImageView *img7 =[[UIImageView alloc] initWithFrame:CGRectMake(160,400,41,41)];
    img7.image=[UIImage imageNamed:@"rice.png"];
    [view_collection addSubview:img7];
    
    UIImageView *img8 =[[UIImageView alloc] initWithFrame:CGRectMake(280,400,41,41)];
    img8.image=[UIImage imageNamed:@"molluscs.png"];
    [view_collection addSubview:img8];
    
    UIImageView *img9 =[[UIImageView alloc] initWithFrame:CGRectMake(400,400,41,41)];
    img9.image=[UIImage imageNamed:@"hotPepper.png"];
    [view_collection addSubview:img9];
    
    ///...................label .....................
    UILabel *lbl6 = [[UILabel alloc]initWithFrame:CGRectMake(50,450 , 41, 15)];
    lbl6.text =@"Gluten";
    lbl6.textAlignment=NSTextAlignmentCenter;
    [lbl6 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl6];
    
    UILabel *lbl7 = [[UILabel alloc]initWithFrame:CGRectMake(160,450 , 41, 15)];
    lbl7.text =@"Rice";
    lbl7.textAlignment=NSTextAlignmentCenter;
    [lbl7 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl7];
    
    UILabel *lbl8 = [[UILabel alloc]initWithFrame:CGRectMake(280,450 , 50, 15)];
    lbl8.text =@"Molluscs";
    lbl8.textAlignment=NSTextAlignmentCenter;
    [lbl8 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl8];
    
    UILabel *lbl9 = [[UILabel alloc]initWithFrame:CGRectMake(390,450 , 70, 15)];
    lbl9.text =@"Hot Pepper";
    lbl9.textAlignment=NSTextAlignmentCenter;
    [lbl9 setFont:[UIFont systemFontOfSize:12]];
    [view_collection addSubview:lbl9];
    
    [self.detailItemDescription addSubview:view_collection];
    
    // Add two buttones   ..................
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateNormal];
    [button setTitle:@"Remove" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    button.frame = CGRectMake(350, 1150, 100.0, 40.0);
    [view_collection addSubview:button];
    
    UIButton *button_2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button_2 setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [button_2 setTintColor:[UIColor whiteColor]];
    [button_2 setTitle:@"Edit" forState:UIControlStateNormal];
    button_2.frame = CGRectMake(460, 1150, 100.0, 40.0);
    [view_collection addSubview:button_2];
    
    [self.detailItemDescription addSubview:button];
    [self.detailItemDescription addSubview:button_2];
    
    UIImageView* customView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc]initWithCustomView:customView2];
    customView2.image = [UIImage imageNamed:@"menu"];
    self.navigationItem.rightBarButtonItem = menuButton;
    UITapGestureRecognizer* menuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    menuTap.delegate = self;
    [customView2 addGestureRecognizer:menuTap];
    
    
    //...... add scroller view
    [self.view addSubview:self.detailItemDescription];
    //...... set content set for scroller
    self.detailItemDescription.contentSize = CGSizeMake(self.detailItemDescription.frame.size.width, 1200);
   
    
}
-(void)showMenu:(id)sender{
    NSLog(@"Yo");
    if ([self.menuTableView isHidden])
    {
        [self.view bringSubviewToFront:self.menuTableView];
        _collectionView.userInteractionEnabled=NO;
       [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLeftTable" object:self];
        [self.menuTableView reloadData];
        self.menuTableView.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.menuTableView.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/2, 0,self.view.frame.size.width/2 , self.view.frame.size.height);
            
        }];
        
    }
    else
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLeftTable2" object:self];
        _collectionView.userInteractionEnabled=YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.menuTableView.frame=CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width/2 , self.view.frame.size.height);
        } completion:^(BOOL finished) {
            [self.menuTableView setHidden:YES];
        }];
        
    }

}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
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
        
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;

    
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row==0) {
        BookingsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookingsViewController"];
        UINavigationController *nav=[self.storyboard instantiateViewControllerWithIdentifier:@"nav"];        
        AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        appdelegate.window.rootViewController=nil;
        appdelegate.window.rootViewController=nav;
        [self.navigationController pushViewController:vc animated:NO];
    }
    if (indexPath.row==4) {
       
        
    }
    
    
    NSLog(@"Hola");
}
#pragma mark TableView mathods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
            return 7;
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"cell";
   
    
    
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
    
    
   
    
    return cell2;
}

@end
