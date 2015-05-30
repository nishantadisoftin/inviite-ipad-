//
//  Dish.m
//  inviite-ipad
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "Dish.h"

@implementation Dish

@synthesize dishId,dishName,dishDescription;

-(id)init{
    self = [super init];
    return self;
}

-(id)initWithDishId:(int)ID name:(NSString*)name description:(NSString*)description{
    dishId = ID;
    dishName = name;
    dishDescription = description;
    return self;
}

@end
