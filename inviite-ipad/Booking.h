//
//  Booking.h
//  inviite-ipad
//
//  Created by Mac on 5/23/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Booking : NSObject

@property (nonatomic,assign) BOOL checked;

@property (nonatomic,copy) UIImage* profileImage;
@property (nonatomic,copy) NSString* dateSent;
@property (nonatomic,copy) NSString* dateOfBooking;
@property (nonatomic,copy) NSString* numberOfGuests;
@property (nonatomic,copy) NSString* guestDetails;
@property (nonatomic,copy) NSString* AgeRange;

@end
