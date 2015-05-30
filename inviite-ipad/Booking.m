//
//  Booking.m
//  inviite-ipad
//
//  Created by Mac on 5/23/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "Booking.h"

@implementation Booking
@synthesize profileImage,dateSent,dateOfBooking,numberOfGuests,guestDetails,AgeRange;

-(id)init{
    self = [super init];
    return self;
}

-(id)initWithProfileImage:(UIImage*)image dateSent:(NSString*)date dateOfBooking:(NSString*)bookingDate numberOfGuests:(NSString*)number guestDetails:(NSString*)details andAgeRange:(NSString*)age{
    profileImage = image;
    dateSent = date;
    dateOfBooking = bookingDate;
    numberOfGuests = number;
    guestDetails = details;
    AgeRange = age;
    return self;
}

@end
