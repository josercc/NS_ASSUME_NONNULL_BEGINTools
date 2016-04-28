//
//  ViewController.m
//  ADDNS_ASSUME_NONNULL_BEGIN_END
//
//  Created by 张行 on 16/4/28.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SelectXcodeTemplteDictionaryChannel.h"

@implementation ViewController

- (NSButton *)openCannelButton
{
    if (!_openCannelButton) {
        
        _openCannelButton = [[NSButton alloc]initWithFrame:NSZeroRect];
        _openCannelButton.title = @"打开XCODE模板的目录";
        _openCannelButton.target = self;
        _openCannelButton.action = @selector(openChannel);
        
    }
    return _openCannelButton;
}

-(void)openChannel {
    
    SelectXcodeTemplteDictionaryChannel *panel = [SelectXcodeTemplteDictionaryChannel xcodeTemplteModel];
    panel.canChooseDirectories = YES;
    panel.selectXcodeTemplteDelegate = self;
    [panel runModal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改XCODE模板";
    [self.view addSubview:self.openCannelButton];
    [self.openCannelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(NSEdgeInsetsZero);
        
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

-(void)didSelectXcodeTemplteURLWithChannel:(SelectXcodeTemplteDictionaryChannel *)channel {
    
    [channel  cancel:channel];
    NSString *urlString = channel.URL.absoluteString;
    
    [self filesWithDictionary:urlString];
    
}

-(void)filesWithDictionary:(NSString *)dic {
    
    
    dic = [dic stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    dic = [dic stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    NSError *error;
    NSArray *contents  = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:dic error:&error];
    
    for (NSString *contentItem  in contents) {
        
        BOOL isDic = NO;
        NSString *s = [dic stringByAppendingString:contentItem];
        
        [[NSFileManager defaultManager] fileExistsAtPath:s isDirectory:&isDic];
        
        if (isDic) {
            
            [self filesWithDictionary:[s stringByAppendingString:@"/"]];
            
            
        }else {
            
            if ([s hasSuffix:@".h"]) {
                
                [self formatterXcodeTemplteWithString:s];
                
            }else if ([s hasSuffix:@".m"]){
                
                [self formatterXcodeTemplteWithString:s];
                
            }
            
            
        }
        
        
        
    }
    
}

-(void)formatterXcodeTemplteWithString:(NSString *)string{
    
    NSLog(@"string->>>%@",string);
    
    NSMutableString *xcodeTemplte = [[NSMutableString alloc]initWithContentsOfFile:string encoding:NSUTF8StringEncoding error:nil];
    
    if (![xcodeTemplte containsString:@"NS_ASSUME_NONNULL_BEGIN"]) {
        
        NSString *beginS = @"@implementation";
        if ([string hasSuffix:@".h"]) {
            beginS =  @"@interface";
        }
        NSRange range = [xcodeTemplte rangeOfString:beginS];
        NSString *begin = [NSString stringWithFormat:@"\nNS_ASSUME_NONNULL_BEGIN\n\n"];
        if (range.location != NSNotFound) {
            
            [xcodeTemplte insertString:begin atIndex:range.location];
            
            
            NSString *ends = @"@end";
            NSRange endRange = [xcodeTemplte rangeOfString:ends];
            NSString *end = @"\n\nNS_ASSUME_NONNULL_END";
            [xcodeTemplte insertString:end atIndex:endRange.location+endRange.length];
            
            NSData *data = [xcodeTemplte dataUsingEncoding:NSUTF8StringEncoding];
            [data writeToFile:string atomically:YES];
            
        }
        
        
    }
    
}


@end
