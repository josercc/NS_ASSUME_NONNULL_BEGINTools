//
//  SelectXcodeTemplteDictionaryChannel.m
//  ADDNS_ASSUME_NONNULL_BEGIN_END
//
//  Created by 张行 on 16/4/28.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "SelectXcodeTemplteDictionaryChannel.h"

@implementation SelectXcodeTemplteDictionaryChannel



+(instancetype)xcodeTemplteModel {
    
    return [super openPanel];
    
}

-(void)ok:(id)sender {
    
    if (self.selectXcodeTemplteDelegate) {
        
        [self.selectXcodeTemplteDelegate didSelectXcodeTemplteURLWithChannel:self];
        
    }
    
}

@end
