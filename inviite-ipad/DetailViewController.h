//
//  DetailViewController.h
//  tablet
//
//  Created by Mac on 5/24/15.
//  Copyright (c) 2015 randomagency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
 NSArray *ary;
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) UIScrollView *detailItemDescription;
@property (strong, nonatomic) UICollectionView *_collectionView;
@property NSInteger getIntergerValue;
@property (nonatomic , retain) NSArray *getArrayName;
@property (nonatomic , retain) NSArray *getArrayImages;
@property (nonatomic , retain) NSArray *ArrayBigImages;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

