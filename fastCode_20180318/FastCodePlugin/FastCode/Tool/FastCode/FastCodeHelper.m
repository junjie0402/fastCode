//
//  FastCodeHelper.m
//  FastCode
//
//  Created by junjie xian on 2018/3/11.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import "FastCodeHelper.h"
#import "FastCodeDef.h"

@interface FastCodeHelper()

@property (nonatomic, strong) NSDictionary *fastCodeMap;

@end

@implementation FastCodeHelper

- (NSDictionary *)fastCodeMap
{
    if (_fastCodeMap == nil) {
        _fastCodeMap = @{
                         FastCodeDef_UI_UILabel_Key:FastCodeDef_UI_UILabel_Value,
                         FastCodeDef_UI_UIButton_Key:FastCodeDef_UI_UIButton_Value,
                         FastCodeDef_UI_UIImageView_Key:FastCodeDef_UI_UIImageView_Value,
                         FastCodeDef_UI_UITabelView_Key:FastCodeDef_UI_UITabelView_Value,
                         FastCodeDef_UI_UIView_Key:FastCodeDef_UI_UIView_Value,
                         
                         FastCodeDef_Property_UILabel_Key:FastCodeDef_Property_UILabel_Value,
                         FastCodeDef_Property_UIButton_Key:FastCodeDef_Property_UIButton_Value,
                         FastCodeDef_Property_UIImageView_Key:FastCodeDef_Property_UIImageView_Value,
                         FastCodeDef_Property_UITableView_Key:FastCodeDef_Property_UITableView_Value,
                         FastCodeDef_Property_INT64_Key:FastCodeDef_Property_INT64_Value,
                         FastCodeDef_Property_UINT64_Key:FastCodeDef_Property_UINT64_Value,
                         FastCodeDef_Property_INT32_Key:FastCodeDef_Property_INT32_Value,
                         FastCodeDef_Property_UINT32_Key:FastCodeDef_Property_UINT32_Value,
                         
                         FastCodeDef_UITableView_DataSource_Key:FastCodeDef_UITableView_DataSource_Value,
                         };
    }
    
    return _fastCodeMap;
}

- (NSString *)constructBlankString:(NSInteger)blankLength
{
    NSString *blankString = @"";
    for (int i = 0; i < blankLength; i++) {
        blankString = [blankString stringByAppendingString:@" "];
    }
    
    return blankString;
}

- (void)replaceString:(XCSourceEditorCommandInvocation *)invocation withReplaceStruct:(FastCodeStruct *)replaceStruct
{
    NSMutableArray *allLinesArray = invocation.buffer.lines;
    XCSourceTextRange *selectedInfo = invocation.buffer.selections.firstObject;
    
    if (replaceStruct && replaceStruct.replaceString.length) {
        NSString *mapString = [self.fastCodeMap objectForKey:[replaceStruct.replaceString lowercaseString]];
        
        if (mapString.length) {
            NSArray *mapStringSeperateArray = [mapString componentsSeparatedByString:@"\n"];
            NSInteger startRow = selectedInfo.start.line;
            
            NSString *firstReplaceLine;
            //替换后字符串只有一行
            if (mapStringSeperateArray.count == 1) {
                NSString *firstStr = [mapStringSeperateArray firstObject];
                firstReplaceLine = [replaceStruct.leftString stringByAppendingFormat:@"%@%@", firstStr, replaceStruct.rightString];
                [allLinesArray replaceObjectAtIndex:startRow withObject:firstReplaceLine];
                
                //调整光标位置
                selectedInfo.start = XCSourceTextPositionMake(selectedInfo.start.line, replaceStruct.leftString.length+firstStr.length);
                selectedInfo.end = selectedInfo.start;
                return ;
            }
            
            //替换字符串有多行（多行就不调整光标位置了，默认多行需要填写多个参数，按tab键切换就好）
            NSInteger count = 0;
            NSInteger insertIndex = startRow + 1;
            NSString *blankString = [self constructBlankString:replaceStruct.leftString.length];
            for (NSString *str in mapStringSeperateArray) {
                if (count == 0) {
                    firstReplaceLine = [replaceStruct.leftString stringByAppendingString:str];
                    [allLinesArray replaceObjectAtIndex:startRow withObject:firstReplaceLine];
                }
                
                if (count > 0 && count != mapStringSeperateArray.count-1) {
                    [allLinesArray insertObject:[blankString stringByAppendingString:str] atIndex:insertIndex];
                    insertIndex++;
                }
                    
                if (count == mapStringSeperateArray.count-1) {
                    NSString *lastReplaceLine = [str stringByAppendingString:replaceStruct.rightString];
                    [allLinesArray insertObject:[blankString stringByAppendingString:lastReplaceLine] atIndex:insertIndex];
                }
                
                count++;
            }
        } else {
            NSLog(@"no map string");
        }
    } else {
        NSLog(@"replaceStruct or replaceStruct.replaceString nil");
    }
}

- (FastCodeStruct *)getReplaceSruct:(XCSourceEditorCommandInvocation *)invocation
{
    FastCodeStruct *replaceStruct = [[FastCodeStruct alloc] init];
    
    NSMutableArray *allLinesArray = invocation.buffer.lines;
    XCSourceTextRange *selectedInfo = invocation.buffer.selections.firstObject;
    
    NSInteger startRow = selectedInfo.start.line;
    NSInteger startColumn = selectedInfo.start.column;
    NSString *startLine = [allLinesArray objectAtIndex:startRow];
    
    NSInteger endRow = selectedInfo.end.line;
    NSInteger endColumn = selectedInfo.end.column;
    
    if (endRow < startRow) {
        NSLog(@"exception : endRow < startRow");
        return replaceStruct;
    }
    
    //情况1：选中多行，不支持文本替换
    if (endRow > startRow) {
        NSLog(@"not support select multi lines");
        return replaceStruct;
    }
    
    NSString *replaceString;
    NSString *leftString;
    NSString *rightString;
    
    //前面的代码保证了endRow=startRow
    //情况2：只选中一行，且选中多个字符，即endColumn>startColumn，则截取[startColumn, endColumn)左开右闭区间字符串
    if (endColumn < startColumn) {
        NSLog(@"exception : endColumn < startColumn");
        return replaceStruct;
    }
    
    if (endColumn > startColumn) {
        replaceString = [startLine substringWithRange:NSMakeRange(startColumn, endColumn-startColumn)];
        replaceString = [replaceString stringByReplacingOccurrencesOfString:@"\n" withString:@""]; //xcode会自动在行末添加\n，这里进行替换可保证取rightString时不越界
        replaceStruct.replaceString = [replaceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        leftString = [startLine substringToIndex:startColumn];
        replaceStruct.leftString = leftString;
        
        NSInteger rightStringStartIndex = leftString.length + replaceString.length; //这里不需要加1
        rightString = [startLine substringFromIndex:rightStringStartIndex];
        replaceStruct.rightString = rightString;
        
        NSLog(@"\nleftString=%@\n replaceString=%@\n rightString=%@", leftString, replaceString, rightString);
        
        return replaceStruct;
    }
    
    //前面的代码保证了endRow=startRow，且endColumn=startColumn
    //情况3：只选中一行，且没选中任何字符，即endColumn=startColumn，则前向回溯截取需要替换的字符串
    if (startColumn <= 0) {  //空行或者非空行但光标置顶，直接return
        NSLog(@"no replaceString");
        return replaceStruct;
    }
    
    replaceString = [self reverseFindReplaceString:startLine startColumn:startColumn];
    replaceStruct.replaceString = [replaceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger replaceStringLeftIndex = startColumn - replaceString.length;
    leftString = [startLine substringToIndex:replaceStringLeftIndex];
    replaceStruct.leftString = leftString;
    
    rightString = [startLine substringFromIndex:startColumn];
    replaceStruct.rightString = rightString;
    
    NSLog(@"\nleftString=%@\n replaceString=%@\n rightString=%@", leftString, replaceString, rightString);

    return replaceStruct;
}

- (NSString *)reverseFindReplaceString:(NSString *)startLine startColumn:(NSInteger)startColumn
{
    NSString *replaceString;
    
    if (startColumn <= 0) {
        return replaceString;
    }
    NSInteger index = startColumn - 1;
    
    while (index >= 0) {
        unichar character = [startLine characterAtIndex:index];
        if ((character >= 'a' && character <= 'z') || (character >= 'A' && character <= 'Z')) {
            index--; //一直为字母，则一直往前回溯
            continue;
        } else {
            break;
        }
    }
    
    if (index < 0) { //表示要替换光标以前的整个串
        replaceString = [startLine substringToIndex:startColumn];
    } else { //表示要替换[index+1, startColumn)左闭右开子串
        replaceString = [startLine substringWithRange:NSMakeRange(index+1, startColumn-(index+1))];
    }

    replaceString = [replaceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return replaceString;
}

@end
