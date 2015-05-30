//
//  BookingsCell.m
//  inviite-ipad
//
//  Created by Mac on 5/21/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import "BookingsCell.h"

@implementation BookingsCell
@synthesize checkButton,confirmButton,declineButton,profilePicture,sentDate,ageRange,numberOfGuests,guestDetails,bookingDate;

- (void)awakeFromNib {
    // Initialization code
    checkButton = [[UIButton alloc]init];
    checkButton.frame = CGRectMake(20, 30, 30, 30);
    [checkButton setBackgroundImage:[UIImage imageNamed:@"uncheckedSwitch"] forState:UIControlStateNormal];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"checkedSwitch"] forState:UIControlStateSelected];
    [self addSubview:checkButton];
    profilePicture = [[UIImageView alloc]initWithFrame:CGRectMake(checkButton.frame.origin.x + 80, 30, 50, 50)];
    profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2;
    profilePicture.backgroundColor = [UIColor redColor];
    profilePicture.image = [UIImage imageNamed:@"profile_image"];
    [profilePicture.layer setMasksToBounds:YES];
    //
    [self addSubview:profilePicture];
    sentDate = [[UILabel alloc]initWithFrame:CGRectMake(profilePicture.frame.origin.x + 100, 0, 100, 100)];
    sentDate.textColor = [UIColor whiteColor];
    sentDate.textAlignment = NSTextAlignmentCenter;
    sentDate.numberOfLines = 2;
    sentDate.text = @"01/05\n14:00";
    [self addSubview:sentDate];
    bookingDate =[[UILabel alloc]initWithFrame:CGRectMake(sentDate.frame.origin.x + 100, 0, 100, 100)];
    bookingDate.textColor = [UIColor whiteColor];
    bookingDate.textAlignment = NSTextAlignmentCenter;
    bookingDate.text = @"12/01";
    [self addSubview:bookingDate];
    numberOfGuests =[[UILabel alloc]initWithFrame:CGRectMake(bookingDate.frame.origin.x + 100, 0, 100, 100)];
    numberOfGuests.textColor = [UIColor whiteColor];
    numberOfGuests.textAlignment = NSTextAlignmentCenter;
    numberOfGuests.text = @"07";
    [self addSubview:numberOfGuests];
    guestDetails =[[UILabel alloc]initWithFrame:CGRectMake(numberOfGuests.frame.origin.x + 100, 0, 100, 100)];
    guestDetails.textColor = [UIColor whiteColor];
    guestDetails.textAlignment = NSTextAlignmentCenter;
    guestDetails.text = @"M:03 - F:03";
    [self addSubview:guestDetails];
    ageRange =[[UILabel alloc]initWithFrame:CGRectMake(guestDetails.frame.origin.x + 100, 0, 100, 100)];
    ageRange.textColor = [UIColor whiteColor];
    ageRange.textAlignment = NSTextAlignmentCenter;
    ageRange.text = @"19-27";
    [self addSubview:ageRange];
    declineButton = [[UIButton alloc]init];
    declineButton.frame = CGRectMake(ageRange.frame.origin.x + 100, 30, 77.5, 33.5);
    [declineButton setBackgroundImage:[UIImage imageNamed:@"Decline"] forState:UIControlStateNormal];
    [self addSubview:declineButton];
    confirmButton = [[UIButton alloc]init];
    confirmButton.frame = CGRectMake(declineButton.frame.origin.x + 100, 30, 77.5, 33.5);
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"Confirm"] forState:UIControlStateNormal];
    [self addSubview:confirmButton];
}


-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
