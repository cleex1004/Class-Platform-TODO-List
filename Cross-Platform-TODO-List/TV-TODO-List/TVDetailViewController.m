//
//  TVDetailViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "TVDetailViewController.h"
#import "Todo.h"

@interface TVDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.currentTodo.title;
    self.contentLabel.text = self.currentTodo.content;
//    [self.titleLabel setText:self.currentTodo.title];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
