//
//  ViewController.h
//  PLChatViewController
//
//  Created by jin on 2015. 6. 5..
//  Copyright (c) 2015년 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UITableView* chatTableView;


- (void)doWrite:(BOOL)isMe;
- (IBAction)doYouWrtie:(id)sender;
- (IBAction)doMeWrite:(id)sender;


@end

