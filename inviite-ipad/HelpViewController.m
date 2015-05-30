//
//  HelpViewController.m
//  inviite-ipad
//
//  Created by Mac on 5/11/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "HelpViewController.h"

@implementation HelpViewController
@synthesize webView;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSURL* url = [NSURL URLWithString:@"http://www.facebook.com"];
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
}

@end
