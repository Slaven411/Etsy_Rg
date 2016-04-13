//
//  CDEtsyCood+CoreDataProperties.h
//  Etsy
//
//  Created by Slaven Kozub on 11/5/15.
//  Copyright © 2015 Slava. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDEtsyCood.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDEtsyCood (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *descr;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *goodId;

@end

NS_ASSUME_NONNULL_END
