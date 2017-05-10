//
//  NewTodoViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/8/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewTodoViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addTodoPressed:(id)sender {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    
    FIRDatabaseReference *userReference = [[databaseReference child:@"users"] child:currentUser.uid];
    FIRDatabaseReference *newTodoReference = [[userReference child:@"todos"] childByAutoId];
    
    [[newTodoReference child:@"title"] setValue:self.titleTextField.text];
    [[newTodoReference child:@"content"] setValue:self.contentTextField.text];
    [[newTodoReference child:@"completed"] setValue:@"0"];
}

//- (IBAction)plusButtonPressed:(id)sender {
//    if (self.containerView.hidden == YES) {
//        self.containerView.hidden = NO;
//        self.heightConstraint.constant = 160;
//        [UIView animateWithDuration:0.6 animations:^{
//            [self.view layoutIfNeeded];
//        }];
//    } else {
//        self.containerView.hidden = YES;
//        self.heightConstraint.constant = 0;
//        [UIView animateWithDuration:0.6 animations:^{
//            [self.view layoutIfNeeded];
//        }];
//    }
//}


@end
