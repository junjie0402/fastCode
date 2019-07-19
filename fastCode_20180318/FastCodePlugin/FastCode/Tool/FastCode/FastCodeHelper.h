//
//  FastCodeHelper.h
//  FastCode
//
//  Created by junjie xian on 2018/3/11.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>
#import "FastCodeStruct.h"

@interface FastCodeHelper : NSObject

- (void)replaceString:(XCSourceEditorCommandInvocation *)invocation withReplaceStruct:(FastCodeStruct *)replaceStruct;

/*
 *getReplaceSruct:获取需要替换前的字符串
 *情况一：选中多行，不支持文本替换
 *情况二：只选中一行，且选中多个字符，则截取[startColumn, endColumn)左开右闭区间字符串
 *情况三：只选中一行，且没选中任何字符，则前向回溯截取需要替换的字符串
 *      从光标当前列（记为列A）往前回溯，直到第一个非字母的字符（记为列B）。
 *      若能回溯到非字母的字符，则需要被替换的字符串为：[B+1, A)左闭右开区间
 *      若没有回溯到非字母的字符，则需要被替换的字符串为：[0, A）左闭右开区间
 */
- (FastCodeStruct *)getReplaceSruct:(XCSourceEditorCommandInvocation *)invocation;

@end
