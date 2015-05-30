//
//  LoginViewController.m
//  inviite-ipad
//
//  Created by Mac on 5/10/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LoginViewController
@synthesize backV,usernameField,passField,loginView,backImage;

-(void)viewDidLoad{
    [super viewDidLoad];

//    UIVisualEffect *blurEffect;
//    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    UIVisualEffectView *visualEffectView;
//    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    
//    visualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    
//    [backV addSubview:visualEffectView];
    
    [self updateTextFields];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.backImage.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    backImage = [[UIImageView alloc]init];
    backImage.frame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65);
    backImage.image = [UIImage imageNamed:@"inviite_back"];
    [self.view insertSubview:backImage belowSubview:loginView];
    backImage.hidden = YES;
    loginView.center = self.view.center;
}

-(void)updateTextFields{
//    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, usernameField.frame.size.height)];
//    usernameField.leftView = paddingView;
//    usernameField.leftViewMode = UITextFieldViewModeAlways;
//    UIImageView* email = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_email_icon"]];
//    email.frame = CGRectMake(10, 10, 26, 18);
//    [paddingView addSubview:email];
//    
//    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, passField.frame.size.height)];
//    passField.leftView = paddingView2;
//    passField.leftViewMode = UITextFieldViewModeAlways;
//    UIImageView* pass = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_password_icon"]];
//    pass.frame = CGRectMake(12, 8, 22, 24);
//    [paddingView2 addSubview:pass];
    

    usernameField.text = @"dav@random.agency";
    passField.text = @"password123";
}

- (void)sendRequest:(id)sender
{
     [SVProgressHUD showWithStatus:@"Logging in..."];

    // login (POST http://inviiteapp.jerrardwayne.net/auth/login)
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Create request
    NSDictionary* URLParameters = @{
                                    @"email":usernameField.text,
                                    @"password":passField.text,
                                    };
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://inviiteapp.jerrardwayne.net/auth/login" parameters:URLParameters error:NULL];
    
    // Add Headers
    [request setValue:@"application/vnd.inviite.v1+json" forHTTPHeaderField:@"Accept"];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             [SVProgressHUD dismiss];

                                                                             NSLog(@"HTTP Response Status Code: %ld", (long)[operation.response statusCode]);
                                                                             NSLog(@"HTTP Response Body: %@", responseObject);
                                                                             NSString *JSON = [responseObject valueForKey:@"token"];                                                                             NSLog(@"Dictionary %@", JSON);
                                                                             [[NSUserDefaults standardUserDefaults] setValue:JSON forKey:@"token"];
                                                                   [self dismissViewControllerAnimated:YES completion:nil];
                                                                             ;
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             [SVProgressHUD dismiss];
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
}


-(IBAction)login:(id)sender{
    [self sendRequest:self];
}

- (IBAction)dismiss:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
