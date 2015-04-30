//
//  VedioDAO.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "VedioDAO.h"
#import "AppDelegate.h"
#import "VedioModel.h"
#import "VedioDB.h"

@implementation VedioDAO
+ (BOOL)save:(VedioModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    
    VedioDB * info = [NSEntityDescription insertNewObjectForEntityForName:@"VedioDB" inManagedObjectContext:context];
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

+ (VedioDB *)findById:(NSString *)aboutId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"VedioDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"vedioid = %@", aboutId];
    
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
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"VedioDB" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    
    return YES;
}

+ (BOOL)deleteById:(NSString *)aboutId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"VedioDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"vedioid = %@", aboutId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    return YES;
}

+ (BOOL)update:(VedioModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"VedioDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"vedioid = %@", model.modelId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    if (resultArr && resultArr.count >0) {
        VedioDB * info = resultArr[0];
        [info fromModel:model];
        if ([context save:&error]) {
            NSLog(@"update about success");
            return YES;
        }else{
            NSLog(@"update about fail");
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
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"VedioDB" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    return resultArr;
}

@end
