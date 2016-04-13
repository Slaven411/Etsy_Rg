//
//  ItemCollectionViewCell.h
//  Etsy
//
//  Created by Slaven Kozub on 10/10/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIImageView *itemImage;


@end
