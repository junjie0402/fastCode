//
//  FastCodeStruct.h
//  FastCode
//
//  Created by junjie xian on 2018/3/17.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FastCodeStruct : NSObject

@property (nonatomic, strong) NSString *leftString;    //被替换的字符串左侧的子串
@property (nonatomic, strong) NSString *replaceString; //被替换的字符串
@property (nonatomic, strong) NSString *rightString;   //被替换的字符串右侧的子串

@end
