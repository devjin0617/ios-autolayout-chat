//
//  PLChatMessageTableViewCell.h
//  PLChatViewController
//
//  Created by jin on 2015. 6. 5..
//  Copyright (c) 2015년 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLChatMessageTableViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) IBOutlet UILabel *datetmeLabel;
@property(nonatomic, strong) IBOutlet UILabel *messageLabel;

@property(nonatomic, strong) IBOutlet UIImageView *bubbleBoxImageView;

@end
