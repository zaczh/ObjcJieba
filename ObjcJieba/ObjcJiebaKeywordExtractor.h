//
//  ObjcJiebaKeywordExtractor.h
//  ObjcJieba
//
//  Created by admin on 07/03/2017.
//  Copyright © 2017 none. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ObjcJiebaKeywordExtractorResult: NSObject
@property (nonatomic, copy) NSString *word;
@property (nonatomic) NSRange range;
@property (nonatomic) double weight;
@end

@interface ObjcJiebaKeywordExtractor : NSObject
- (instancetype)initWithDictPath: (NSString *)dicpath
                     hmmFilePath: (NSString *)hmmFilePath
                         idfPath: (NSString *)idfPath
                    stopWordPath: (NSString *)stopWordPath
                        userDict: (NSString *)userDict;
- (void)extract:(NSString *)str completion:(void (^)(NSArray<ObjcJiebaKeywordExtractorResult *>*, NSError *))completion;
@end
