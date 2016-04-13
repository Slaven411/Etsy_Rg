//
//  SearchViewController.m
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import "SearchViewController.h"

#import "CategoriesManager.h"
#import "EtsyCategory.h"

#import "ItemsViewController.h"

@interface SearchViewController () <UIPickerViewDataSource, UIPickerViewDelegate, CategoriesManagerDelegat>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;

@property (strong, nonatomic) NSArray *categories;

@end

@implementation SearchViewController
- (IBAction)submitButtonTapped:(id)sender {
  
  [[CategoriesManager sharedInstance] searchItem:self.searchField.text forCategory:self.categoryButton.titleLabel.text];
  
}
- (IBAction)categoryButtonTapped:(id)sender {
  self.categoryPicker.hidden = !self.categoryPicker.hidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  [CategoriesManager sharedInstance].delagate = self;
  self.categories = [CategoriesManager sharedInstance].categories;
  EtsyCategory *cat = self.categories.firstObject;
  [self.categoryButton setTitle:cat.name forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

-(void) categoriesReady:(NSArray *)categories {
  
  self.categories = categories;
  
  EtsyCategory *cat = self.categories.firstObject;
  [self.categoryButton setTitle:cat.name forState:UIControlStateNormal];
  
  [self.categoryPicker reloadAllComponents];
  

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.searchField resignFirstResponder];
  self.categoryPicker.hidden = YES;
}

- (void)itemsLoad:(NSArray *)items{
  
  [self performSegueWithIdentifier:@"ShowItemsViewController" sender:items];
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"ShowItemsViewController"]) {
    ItemsViewController *itemsVC = segue.destinationViewController;
    itemsVC.items = sender;
    itemsVC.showFromNetwork = YES;
  }
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  return [self.categories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  EtsyCategory *category = self.categories[row];
  return category.name;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
  EtsyCategory *cat = [self.categories objectAtIndex:row];
  [self.categoryButton setTitle:cat.name forState:UIControlStateNormal];
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
