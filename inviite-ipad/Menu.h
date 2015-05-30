//
//  Menu.h
//  inviite-ipad
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Menu : NSObject

@property (nonatomic,assign) int menuId;
@property (nonatomic,copy) NSString* menuName;
@property (nonatomic,copy) NSString* menuDescription;

@end
