//
//  ViewController.m
//  PLChatViewController
//
//  Created by jin on 2015. 6. 5..
//  Copyright (c) 2015년 jin. All rights reserved.
//

#import "ViewController.h"
#import "PLChatMessageTableViewCell.h"

@interface ViewController () {
    NSMutableArray *chatData;
    
    PLChatMessageTableViewCell *_stubCell;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    chatData = [[NSMutableArray alloc]init];
    
    UINib *cellNib = [UINib nibWithNibName:@"PLChatTableViewCell" bundle:nil];
    [_chatTableView registerNib:cellNib forCellReuseIdentifier:@"PLChatMessageTableViewCell"];
    _stubCell = [cellNib instantiateWithOwner:nil options:nil][0];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    
    
    
    [self loadData];
}

- (void)loadData {
    
    NSDictionary *item = [[NSDictionary alloc]initWithObjectsAndKeys:
                          @"jin", @"name",
                          @"hello world", @"message", nil];
    [chatData addObject:item];
    
    for (int i=0; i<10; i++) {
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"jin", @"name",
                @"hello world,hello world,hello world,hello world,", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"jin", @"name",
                @"hello world", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"jin", @"name",
                @"hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"jin", @"name",
                @"hello world,hello world,", @"message", nil];
        [chatData addObject:item];

    }
    
    
    
    [self.chatTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return [chatData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self configureCell:_stubCell atIndexPath:indexPath];
    [_stubCell layoutSubviews];
    CGFloat height = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;

}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40.f;
//}

- (void)configureCell:(PLChatMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [chatData objectAtIndex:[indexPath row]];
    
    cell.messageLabel.text = [item valueForKey:@"message"];
    cell.nameLabel.text = [item valueForKey:@"name"];
    
    
    [cell.bubbleBoxImageView setImage:[[UIImage imageNamed:@"bubblebox_you.png"] stretchableImageWithLeftCapWidth:33 topCapHeight:25]];

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PLChatMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLChatMessageTableViewCell" forIndexPath:indexPath];

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (IBAction)doWrtie:(id)sender {
    
    NSArray *randomArray = [[NSArray alloc] initWithObjects:
                            @"hello world,hello world",
                            @"hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world",
                            @"hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world",
                            @"hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world",
                            @"hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world",
                            @"hello world,hello world",
                            @"hello world,hello world,hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world, hello world,hello world",
                            @"hello world,hello world hello world,hello world"
                            , nil];
    
    int nRnd = arc4random() % [randomArray count];
    
    
    NSDictionary *item = [[NSDictionary alloc]initWithObjectsAndKeys:
            @"jin", @"name",
            [randomArray objectAtIndex:nRnd], @"message", nil];
    [chatData addObject:item];
    
    [_chatTableView reloadData];
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatData count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

@end
