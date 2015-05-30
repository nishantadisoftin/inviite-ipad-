//
//  BookingsCell.h
//  inviite-ipad
//
//  Created by Mac on 5/21/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingsCell : UITableViewCell

@property (nonatomic,strong) UIButton* checkButton;
@property (nonatomic, strong) UIImageView* profilePicture;
@property (nonatomic,strong) UILabel* sentDate;
@property (nonatomic,strong) UILabel* bookingDate;
@property (nonatomic,strong) UILabel* numberOfGuests;
@property (nonatomic,strong) UILabel* guestDetails;
@property (nonatomic,strong) UILabel* ageRange;
@property (nonatomic,strong) UIButton* confirmButton;
@property (nonatomic,strong) UIButton* declineButton;


@end
