//
//  ItemDeteilViewController.h
//  Etsy
//
//  Created by Slaven Kozub on 10/29/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EtsyGood.h"

@interface ItemDeteilViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *productView;
@property (nonatomic, weak) IBOutlet UILabel *price;
@property (nonatomic, weak) IBOutlet UILabel *productTitle;
@property (nonatomic, weak) IBOutlet UILabel *productDescription;
@property (nonatomic, weak) IBOutlet UIButton *saveDeleteButton;
@property (nonatomic, strong) EtsyGood *product;
@property (nonatomic, strong) UIImage *productImage;


@end
