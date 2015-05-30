//
//  Dish.h
//  inviite-ipad
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Dish : NSObject

@property (nonatomic,assign) int dishId;
@property (nonatomic,copy) NSString* dishName;
@property (nonatomic,copy) NSString* dishDescription;

@end
