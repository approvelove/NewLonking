//
//  EmployeeDAO.m
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "EmployeeDAO.h"
#import "AppDelegate.h"
#import "EmployeeDB.h"
#import "EmployeeModel.h"

@implementation EmployeeDAO

+ (BOOL)save:(EmployeeModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    
    EmployeeDB * info = [NSEntityDescription insertNewObjectForEntityForName:@"EmployeeDB" inManagedObjectContext:context];
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

+ (EmployeeDB *)findById:(NSString *)employeeId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"EmployeeDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"employeeId = %@", employeeId];
    
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
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"EmployeeDB" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    
    return YES;
}

+ (BOOL)deleteById:(NSString *)employeeId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"EmployeeDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"employeeId = %@", employeeId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    return YES;
}

+ (BOOL)update:(EmployeeModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"EmployeeDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"employeeId = %@", model.modelId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    if (resultArr && resultArr.count >0) {
        EmployeeDB * info = resultArr[0];
        [info fromModel:model];
        if ([context save:&error]) {
            NSLog(@"update employee success");
            return YES;
        }else{
            NSLog(@"update employee fail");
            return NO;
        }
    }else{
        return NO;
    }
}

@end
