//
//  TVHomeViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/9/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "TVHomeViewController.h"
#import "Todo.h"
#import "TVDetailViewController.h"
#import "FirebaseAPI.h"

@interface TVHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos) {
//        NSLog(@"%@", allTodos);
//        self.allTodos = allTodos;
//        [self.tableView reloadData];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Todo *currentTodo = [[Todo alloc]init];
    currentTodo.title = self.allTodos[indexPath.row].title;
    currentTodo.content = self.allTodos[indexPath.row].content;
    
    TVDetailViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TVDetailViewController"];
    newVC.currentTodo = currentTodo;
    
    [self presentViewController:newVC animated:YES completion:nil];
}


@end

//-(NSArray<Todo *> *)allTodos{
//    Todo *firstTodo = [[Todo alloc]init];
//    firstTodo.title = @"First Todo";
//    firstTodo.content = @"This is a todo.";
//
//    Todo *secondTodo = [[Todo alloc]init];
//    secondTodo.title = @"Second Todo";
//    secondTodo.content = @"This is a todo.";
//
//    Todo *thirdTodo = [[Todo alloc]init];
//    thirdTodo.title = @"Third Todo";
//    thirdTodo.content = @"This is a todo.";
//
//    return @[firstTodo, secondTodo, thirdTodo];
//}
