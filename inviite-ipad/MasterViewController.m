//
//  MasterViewController.m
//  tablet
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface MasterViewController ()

@property NSMutableArray *objects;

@end

@implementation MasterViewController
@synthesize aryMenu,aryAllData;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    aryMenu=[NSArray arrayWithObjects:@"Cocktail List",
             @"Seafood Menu", @"From the Grill", @"A la Carte",
             @"Appetizers", @"Wine List", nil];
    
    self.tableView.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [self getMenu];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkRes:) name:@"updateLeftTable" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkRes2:) name:@"updateLeftTable2" object:nil];
}
-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updateLeftTable"])
    {
        self.view.userInteractionEnabled=NO;
    }
}
-(void)checkRes2:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updateLeftTable2"])
    {
        self.view.userInteractionEnabled=YES;
    }
}
-(void)getMenu
{
    //http://inviiteapp.jerrardwayne.net/bookings?include=venue,plan
    
    aryAllData=[[NSMutableArray alloc]init];
    
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSString *string=[NSString stringWithFormat:@"Bearer %@",token];
    
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://inviiteapp.jerrardwayne.net/menus" parameters:nil error:NULL];
    
    // Add Headers
    [request setValue:@"application/vnd.inviite.v1+json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXUyJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cL2FwaS5pbnZpaXRlLmRldlwvYXV0aFwvbG9naW4iLCJpYXQiOiIxNDMxNzY1MjQ0IiwiZXhwIjoiMTQzMjk3NDg0NCIsIm5iZiI6IjE0MzE3NjUyNDQiLCJqdGkiOiIwYmY1OTM0NjlhZGVmNDdkMmE2YmYxYzY0ZDIwZTEwZCJ9.MDdhYjBhNzY1NTg0YTc5ZmM2NjljZWE2MGFhZDFkYTYyYTcyNDFhNWYyNmVkYmM0NTEzMGNjODNlMDUzMDcwMQ" forHTTPHeaderField:@"Authorization"];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject)
                                         {
                                             //   [SVProgressHUD dismiss];
                                             
                                             NSLog(@"HTTP Response Status Code: %ld", (long)[operation.response statusCode]);
                                             
                                             aryAllData = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                     options:kNilOptions error:nil];
                                             NSLog(@"plans-----%@", [aryAllData  valueForKey:@"data"]);
                                         }
                                         
                                         
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             //    [SVProgressHUD dismiss];
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
       // NSLog(@"Hola");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [self.detailViewController setDetailItem:object];
        
        self.detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        if (self.detailViewController._collectionView.hidden == YES) {
            self.detailViewController._collectionView.hidden = NO;
            return;
        }
        self.detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
       // self.detailViewController._collectionView=[[UICollectionView alloc] initWithFrame:self.detailViewController.view.frame collectionViewLayout:layout];
        
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        
          self.detailViewController._collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 680, 690) collectionViewLayout:layout];
        
        [self.detailViewController._collectionView setDataSource:self.detailViewController];
        [self.detailViewController._collectionView setDelegate:self.detailViewController];
        
        [self.detailViewController._collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [self.detailViewController._collectionView setBackgroundColor:[UIColor clearColor]];
        
        [self.detailViewController.view addSubview:self.detailViewController._collectionView];
        [self.detailViewController.view setNeedsDisplay];
        self.detailViewController.title=[aryMenu objectAtIndex:indexPath.row];
        self.detailViewController.getIntergerValue=indexPath.row;
        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [aryMenu count];
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    textLabel.text = @"Menus";
    textLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:textLabel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    cell.textLabel.text =[aryMenu objectAtIndex:indexPath.row];
    //[NSString stringWithFormat:@"Menu %d",indexPath.row + 1];
    return cell;
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
