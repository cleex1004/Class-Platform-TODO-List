//
//  LoginViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/8/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "LoginViewController.h"
@import FirebaseAuth;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *errorButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)loginPressed:(id)sender {
    [[FIRAuth auth]signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error Signing In: %@", error.localizedDescription);
            [self.errorButton setTitle:@"There was an error logging in. Tap to dismiss and try again." forState:UIControlStateNormal]
            ;
            self.errorButton.hidden = NO;
        }
        
        if (user) {
            NSLog(@"Logged In User: %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)signupPressed:(id)sender {
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Signing Up: %@", error.localizedDescription);
            [self.errorButton setTitle:@"There was an error signing up. Tap to dismiss and try again." forState:UIControlStateNormal]
            ;
            self.errorButton.hidden = NO;
        }
        
        if (user) {
            NSLog(@"Successfully Signed Up User: %@", user);
        }
    }];
}

- (IBAction)errorPressed:(id)sender {
    self.emailTextField.text = nil;
    self.passwordTextField.text = nil;
    
    [self.errorButton setHidden:YES];
    
}



@end

//NSError *signOutError;
//[[FIRAuth auth]signOut:@signOutError];
