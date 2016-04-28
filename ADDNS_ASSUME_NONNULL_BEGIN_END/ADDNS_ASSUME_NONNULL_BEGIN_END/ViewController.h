//
//  ViewController.h
//  ADDNS_ASSUME_NONNULL_BEGIN_END
//
//  Created by 张行 on 16/4/28.
//  Copyright © 2016年 张行. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SelectXcodeTemplteDictionaryChannel.h"
@interface ViewController : NSViewController<SelectXcodeTemplteDictionaryChannelDelegate>

@property (nonatomic, strong) NSButton *openCannelButton;

@end

