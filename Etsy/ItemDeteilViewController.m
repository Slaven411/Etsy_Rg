//
//  ItemDeteilViewController.m
//  Etsy
//
//  Created by Slaven Kozub on 10/29/15.
//  Copyright © 2015 Slava. All rights reserved.
///Users/romaherman/Documents/Projects/Etsy/Etsy/itemPlaceholder.png

#import "ItemDeteilViewController.h"

#import "CategoriesManager.h"

@interface ItemDeteilViewController ()

@end

@implementation ItemDeteilViewController

- (IBAction)saveDeleteButtonTapped:(id)sender {
  
  if ([[CategoriesManager sharedInstance] existEntity:self.product.goodID]) {
    [[CategoriesManager sharedInstance] deleteItem:self.product];

  } else {
    [[CategoriesManager sharedInstance] addItem:self.product];

  }
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.productDescription.text = self.product.itemDescription;
  [self.productDescription setPreferredMaxLayoutWidth:self.view.frame.size.width - 40.0];
//  [self.productDescription layoutIfNeeded];
  
  self.productTitle.text = self.product.title;
  CGFloat titleWidth = self.view.frame.size.width - self.productView.frame.size.width - 20.0;
  [self.productTitle setPreferredMaxLayoutWidth:titleWidth];
  
  self.price.text = self.product.price;
  
  self.productView.image = self.productImage;
  
  if ([[CategoriesManager sharedInstance] existEntity:self.product.goodID]) {
    [self.saveDeleteButton setTitle:@"Delete" forState:UIControlStateNormal];
  } else {
    [self.saveDeleteButton setTitle:@"Add" forState:UIControlStateNormal];
  }
  
  
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
