//
//  ObjcJiebaKeywordExtractor.h
//  ObjcJieba
//
//  Created by admin on 07/03/2017.
//  Copyright © 2017 none. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ObjcJiebaKeywordExtractorResult: NSObject
@property (nonatomic, copy) NSString * _Nonnull word;
@property (nonatomic) NSRange range;
@property (nonatomic) double weight;
@end

@interface ObjcJiebaKeywordExtractor : NSObject
- (instancetype _Nonnull)initWithDictPath: (NSString * _Nullable)dicpath
                     hmmFilePath: (NSString * _Nullable)hmmFilePath
                         idfPath: (NSString * _Nullable)idfPath
                    stopWordPath: (NSString * _Nullable)stopWordPath
                        userDict: (NSString * _Nullable)userDict;
- (void)extract:(NSString * _Nonnull)str completion:(void (^ _Nullable)(NSArray<ObjcJiebaKeywordExtractorResult *>* _Nullable results, NSError *_Nullable error))completion;
@end
