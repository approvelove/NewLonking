//
//  FormViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-23.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "FormViewController.h"
#import "OSTTextView.h"
#import "Customers.h"
#import "FeedBackBiz.h"

@interface FormViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *companyNameField;
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *emailField;
}
@end

@implementation FormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSendCustomInfo) name:@"notification submit customer info From contactViewController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPostCustomerInfoComplete:) name:FEEDBACK_NOTIFICATION_POST_CUSTOMERINFO object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initSelf];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  界面初始化
- (void)initSelf
{
    
}

//load data


#pragma mark -通知回调
- (void)notificationSendCustomInfo
{
    Customers *tempModel = [[Customers alloc] init];
    tempModel.interestedProductName = @"";
    tempModel.country = companyNameField.text;
    tempModel.email = emailField.text;
    tempModel.name = nameField.text;
    [FeedBackBiz startSendCustomerInfoToServiceWithWithCustomers:tempModel];
}

- (void)requestPostCustomerInfoComplete:(NSNotification *)notification
{
    if (notification.userInfo[@"oldData"]) {
        //说明提交成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"submit success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"submit CustomerInfo success from FormView" object:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"submit failed" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.tableView.scrollEnabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tableView.scrollEnabled = NO;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
