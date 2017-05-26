//
//  EmailViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "EmailViewController.h"
#import "TVHomeViewController.h"

@interface EmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)donePressed:(id)sender {
    TVHomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TVHomeViewController"];
    homeVC.email = self.emailTextField.text;
    
    [self presentViewController:homeVC animated:YES completion:nil];
}


@end
