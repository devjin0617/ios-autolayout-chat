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
    PLChatMessageTableViewCell *_stubMeCell;
    
    PLChatMessageTableViewCell *_mainCell;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    chatData = [[NSMutableArray alloc]init];
    
    UINib *cellYouNib = [UINib nibWithNibName:@"PLChatTableViewYouCell" bundle:nil];
    UINib *cellMeNib = [UINib nibWithNibName:@"PLChatTableViewMeCell" bundle:nil];
    
    [_chatTableView registerNib:cellYouNib forCellReuseIdentifier:@"PLChatMessageTableViewYouCell"];
    [_chatTableView registerNib:cellMeNib forCellReuseIdentifier:@"PLChatMessageTableViewMeCell"];
    _stubCell = [cellYouNib instantiateWithOwner:nil options:nil][0];
    _stubMeCell = [cellMeNib instantiateWithOwner:nil options:nil][0];
    
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
                @"NO", @"isMe",
                @"jin", @"name",
                @"hello world,hello world,hello world,hello world,", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"NO", @"isMe",
                @"jin", @"name",
                @"hello world", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"NO", @"isMe",
                @"jin", @"name",
                @"hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"NO", @"isMe",
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
    
    [self configureCell:nil atIndexPath:indexPath];
    [_mainCell layoutSubviews];
    CGFloat height = [_mainCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
    
}

// what is estimatedHeightForRowAtIndexPath? ~_~........ i don't no.....
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40.f;
//}

- (void)configureCell:(PLChatMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [chatData objectAtIndex:[indexPath row]];
    
    if([[item valueForKey:@"isMe"] isEqualToString:@"YES"]) {
        _mainCell = cell==nil?_stubMeCell:cell;
        [_mainCell.bubbleBoxImageView setImage:[[UIImage imageNamed:@"bubblebox_me.png"] stretchableImageWithLeftCapWidth:22 topCapHeight:25]];
    } else {
        _mainCell = cell==nil?_stubCell:cell;;
        [_mainCell.bubbleBoxImageView setImage:[[UIImage imageNamed:@"bubblebox_you.png"] stretchableImageWithLeftCapWidth:33 topCapHeight:25]];
    }
    
    _mainCell.messageLabel.text = [item valueForKey:@"message"];
    
    @try {
        _mainCell.nameLabel.text = [item valueForKey:@"name"];
    } @catch(NSException *e) {
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = [chatData objectAtIndex:[indexPath row]];
    
    
    PLChatMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[item valueForKey:@"isMe"] isEqualToString:@"YES"] ? @"PLChatMessageTableViewMeCell" : @"PLChatMessageTableViewYouCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (IBAction)doYouWrtie:(id)sender {
    [self doWrite:NO];
    
}

- (IBAction)doMeWrite:(id)sender {
    [self doWrite:YES];
}

- (void)doWrite:(BOOL)isMe {
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
    
    NSString *strIsMe = isMe ? @"YES" : @"NO";
    NSDictionary *item = [[NSDictionary alloc]initWithObjectsAndKeys:
                          strIsMe, @"isMe",
                          @"jin", @"name",
                          [randomArray objectAtIndex:nRnd], @"message", nil];
    [chatData addObject:item];
    
    [_chatTableView reloadData];
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatData count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
