//
//  ItemsViewController.m
//  Etsy
//
//  Created by Slaven Kozub on 10/10/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import "ItemsViewController.h"

#import "ItemCollectionViewCell.h"

#import "EtsyGood.h"

#import "CategoriesManager.h"

#import "UIImageView+AFNetworking.h"

#import "ItemDeteilViewController.h"

@interface ItemsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>



@property (nonatomic, weak) IBOutlet UICollectionView *itemsCollection;

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  /*if (!self.showFromNetwork) {
    self.items = [[CategoriesManager sharedInstance] fetchAllItems ];
  }
  */
  
  NSLog(@"RECEIVED ITEMS = %@",self.items);
}

- (void)viewWillAppear:(BOOL)animated{
  
  if (!self.showFromNetwork) {
    self.items = [[CategoriesManager sharedInstance] fetchAllItems ];
    [self.itemsCollection reloadData];
  }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"ItemCollectionViewCell";
  
  ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
  
  //fill cell with data
  EtsyGood *etsyGood = [self.items objectAtIndex:indexPath.row];
  cell.title.text = etsyGood.title;
  [cell.title setPreferredMaxLayoutWidth:cell.frame.size.width - 10.0];
  [[CategoriesManager sharedInstance] loadImageForListing:etsyGood.goodID withComplition:^(NSString *stringURL) {
    [cell.itemImage setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"itemPlaceholder"]];
  }];
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  if ([segue.identifier isEqualToString:@"ShowDetaileView"]) {
    ItemDeteilViewController *detailVc = segue.destinationViewController;
    
    ItemCollectionViewCell *cell = sender;
    NSIndexPath *cellIndex = [self.itemsCollection indexPathForCell:cell];
    EtsyGood *etsyGood = [self.items objectAtIndex:cellIndex.row];
    
    detailVc.product = etsyGood;
    detailVc.productImage = cell.itemImage.image;
    
  }
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
