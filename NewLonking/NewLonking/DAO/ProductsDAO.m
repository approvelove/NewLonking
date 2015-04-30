//
//  ProductsDAO.m
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ProductsDAO.h"
#import "ProductsDB.h"
#import "Products.h"
#import "AppDelegate.h"

@implementation ProductsDAO

+ (BOOL)save:(Products *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    
    ProductsDB * info = [NSEntityDescription insertNewObjectForEntityForName:@"ProductsDB" inManagedObjectContext:context];
    [info fromModel:model];
    
    NSError * error;
    if ([context save:&error]) {
        NSLog(@"save users success");
        return YES;
    }else{
        NSLog(@"save users fail");
        return NO;
    }
}

+ (ProductsDB *)findById:(NSString *)productsId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ProductsDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productsId = %@", productsId];
    
    //    排序
    //    NSSortDescriptor * sort = [[NSortDescriptor alloc] initWithKey:@"name"];
    //    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    
    [request setEntity:entity];
    [request setPredicate: predicate];
    //    [fetch setSortDescriptors: sortDescriptors];
    
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    if (resultArr == nil || resultArr.count == 0) {
        return nil;
    }else{
        return resultArr[0];
    }
}

+ (BOOL)clearData
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ProductsDB" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    
    return YES;
}

+ (BOOL)deleteById:(NSString *)productsId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ProductsDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productsId = %@", productsId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    return YES;
}

+ (BOOL)update:(Products *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ProductsDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productsId = %@", model.modelId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    if (resultArr && resultArr.count >0) {
        ProductsDB * info = resultArr[0];
        [info fromModel:model];
        if ([context save:&error]) {
            NSLog(@"update product success");
            return YES;
        }else{
            NSLog(@"update product fail");
            return NO;
        }
    }else{
        return NO;
    }
}

+ (NSArray *)findAll
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ProductsDB" inManagedObjectContext:context];
    
    //    排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"orderindex" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setEntity:entity];
    
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    return resultArr;
}
@end
