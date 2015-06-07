//
//  ViewController.m
//  PLChatViewController
//
//  Created by jin on 2015. 6. 5..
//  Copyright (c) 2015년 jin. All rights reserved.
//

#import "ViewController.h"
#import "PLChatMessageTableViewCell.h"
#import "PLChatTableViewNoticeCell.h"

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
                          @"you", @"type",
                          @"jin", @"name",
                          @"hello world", @"message", nil];
    [chatData addObject:item];
    
    for (int i=0; i<10; i++) {
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"you", @"type",
                @"jin", @"name",
                @"hello world,hello world,hello world,hello world,", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"you", @"type",
                @"jin", @"name",
                @"hello world", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"you", @"type",
                @"jin", @"name",
                @"hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,hello world,", @"message", nil];
        [chatData addObject:item];
        
        item = [[NSDictionary alloc]initWithObjectsAndKeys:
                @"you", @"type",
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
    
    NSDictionary *item = [chatData objectAtIndex:[indexPath row]];
    
    if([[item valueForKey:@"type"] isEqualToString:@"notice"]) {
        return 40.0f;
    }
    
    [self configureCell:nil atIndexPath:indexPath];
//    [_mainCell layoutSubviews];
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
    
    if([[item valueForKey:@"type"] isEqualToString:@"me"]) {
        _mainCell = cell==nil?_stubMeCell:cell;
        [_mainCell.bubbleBoxImageView setImage:[[UIImage imageNamed:@"bubblebox_me.png"] stretchableImageWithLeftCapWidth:22 topCapHeight:25]];
    } else if([[item valueForKey:@"type"] isEqualToString:@"you"]) {
        _mainCell = cell==nil?_stubCell:cell;;
        [_mainCell.bubbleBoxImageView setImage:[[UIImage imageNamed:@"bubblebox_you.png"] stretchableImageWithLeftCapWidth:33 topCapHeight:25]];
    } else {
        return;
    }
    
    _mainCell.messageLabel.text = [item valueForKey:@"message"];
    
    @try {
        _mainCell.nameLabel.text = [item valueForKey:@"name"];
    } @catch(NSException *e) {
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = [chatData objectAtIndex:[indexPath row]];
    
    NSString *strType = [item valueForKey:@"type"];
    
    PLChatMessageTableViewCell *cell = nil;
    
    if([strType isEqualToString:@"me"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PLChatMessageTableViewMeCell" forIndexPath:indexPath];
    } else if([strType isEqualToString:@"you"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PLChatMessageTableViewYouCell" forIndexPath:indexPath];
    } else {
        PLChatTableViewNoticeCell *noticeCell = [tableView dequeueReusableCellWithIdentifier:@"PLChatTableViewNoticeCell"];
                
        if(noticeCell == nil) {
            noticeCell = [[[NSBundle mainBundle] loadNibNamed:@"PLChatTableViewNoticeCell" owner:nil options:0] objectAtIndex:0];
        }
        
        noticeCell.noticeLabel.text = [item valueForKey:@"message"];
        
        return noticeCell;

    }
    
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}


- (IBAction)doYouWrtie:(id)sender {
    [self doWrite:NO];
    
}

- (IBAction)doMeWrite:(id)sender {
    [self doWrite:YES];
}

- (IBAction)doNoticeWrite:(id)sender {
    
    NSArray *randomArray = [[NSArray alloc] initWithObjects:
                                @"홍길동님이 초대되었습니다.",
                                @"홍길동님이 나갔습니다.",
                                @"새로운방에 초대되었습니다.",
                                nil];
    
    int nRnd = arc4random() % [randomArray count];
    
    NSDictionary *item = [[NSDictionary alloc]initWithObjectsAndKeys:
                          @"notice", @"type",
                          @"jin", @"name",
                          [randomArray objectAtIndex:nRnd], @"message", nil];
    [chatData addObject:item];
    
    [_chatTableView reloadData];
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatData count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
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
    
    NSString *strIsMe = isMe ? @"me" : @"you";
    NSDictionary *item = [[NSDictionary alloc]initWithObjectsAndKeys:
                          strIsMe, @"type",
                          @"jin", @"name",
                          [randomArray objectAtIndex:nRnd], @"message", nil];
    [chatData addObject:item];
    
    [_chatTableView reloadData];
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatData count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
