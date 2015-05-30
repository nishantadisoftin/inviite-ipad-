//
//  LoginViewController.h
//  inviite-ipad
//
//  Created by Mac on 5/10/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@end
