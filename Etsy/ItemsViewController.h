//
//  ItemsViewController.h
//  Etsy
//
//  Created by Slaven Kozub on 10/10/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UIViewController

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,assign) BOOL showFromNetwork;

@end
