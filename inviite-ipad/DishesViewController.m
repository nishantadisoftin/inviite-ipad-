//
//  MasterViewController.m
//  tablet
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "DishesViewController.h"
#import "DetailViewController.h"

@interface DishesViewController ()

@property NSMutableArray *objects;
@end

@implementation DishesViewController
@synthesize getIntergerValue,getArrayName,ArrayBigImages;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    getIntergerValue=self.detailViewController.getIntergerValue;
    getArrayName=[NSArray arrayWithObjects:@"Bellini",
                  @"Cosmopolitan", @"Martini", @"Negroni",
                  @"Old Fashioned", @"Mojito", nil];
    ArrayBigImages=[NSArray arrayWithObjects:@"bellini.jpg",
                    @"cosmopolitan.jpg", @"martini.jpg", @"mojito.jpg",
                    @"negroni.jpg", @"oldFashioned.jpg", nil];
      self.tableView.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
//    self.detailViewController.detailDescriptionLabel.text = @"YEAH";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"ViewDid Dissapear");
    [super viewDidDisappear:animated];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self.detailViewController._collectionView removeFromSuperview];
    [self.detailViewController.detailItemDescription removeFromSuperview];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Menus";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    //textLabel.backgroundColor=[UIColor greenColor];
    textLabel.text = @"Dishes";
    textLabel.textAlignment=NSTextAlignmentCenter;
    [headerView addSubview:textLabel];
    return headerView;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    cell.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    
    cell.textLabel.text =[getArrayName objectAtIndex:indexPath.row];
    //[NSString stringWithFormat:@"Dish %d",indexPath.row + 1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [self.detailViewController._collectionView removeFromSuperview];
    [self.detailViewController.detailItemDescription removeFromSuperview];
    self.detailViewController.detailItemDescription = [[UIScrollView alloc]initWithFrame:CGRectMake(60, 40, 580,664)];
    self.detailViewController.detailItemDescription.backgroundColor = [UIColor clearColor];
    [self.detailViewController.detailItemDescription setShowsHorizontalScrollIndicator:NO];
    [self.detailViewController.detailItemDescription setShowsVerticalScrollIndicator:NO];
    
    // ...... 1 Top image
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,580,600)];
    dot.image=[UIImage imageNamed:[ArrayBigImages objectAtIndex:indexPath.row]];
    dot.backgroundColor=[UIColor clearColor];
    [self.detailViewController.detailItemDescription addSubview:dot];
    
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
    //lbl1.backgroundColor=[UIColor redColor];
    [view_collection addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(160,350 , 41, 15)];
    lbl2.text =@"Poultry";
    lbl2.textAlignment=NSTextAlignmentCenter;
    [lbl2 setFont:[UIFont systemFontOfSize:12]];
    //lbl2.backgroundColor=[UIColor redColor];
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
    
    [self.detailViewController.detailItemDescription addSubview:view_collection];
    
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
    
    [self.detailViewController.detailItemDescription addSubview:button];
    [self.detailViewController.detailItemDescription addSubview:button_2];
    
    //...... add scroller view
    [self.detailViewController.view addSubview:self.detailViewController.detailItemDescription];
    //...... set content set for scroller
     self.detailViewController.detailItemDescription.contentSize = CGSizeMake(self.detailViewController.detailItemDescription.frame.size.width, 1200);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
