//
//  Menu.m
//  inviite-ipad
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "Menu.h"

@implementation Menu

@synthesize menuId,menuName,menuDescription;

-(id)init{
    self = [super init];
    return self;
}

-(id)initWithMenuId:(int)ID name:(NSString*)name description:(NSString*)description{
    menuId = ID;
    menuName = name;
    menuDescription = description;
    return self;
}

@end
