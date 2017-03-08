//
//  ObjcJiebaKeywordExtractor.m
//  ObjcJieba
//
//  Created by admin on 07/03/2017.
//  Copyright © 2017 none. All rights reserved.
//

#import "ObjcJiebaKeywordExtractor.h"
#include "KeywordExtractor.hpp"
#include <vector>

@implementation ObjcJiebaKeywordExtractorResult
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"(word: %@ range: (%lu, %lu) weight: %f)", self.word, (unsigned long)self.range.location, (unsigned long)self.range.length, self.weight];
}
@end

@interface ObjcJiebaKeywordExtractor ()
@property (nonatomic, assign) cppjieba::KeywordExtractor *extractor;
@end

@implementation ObjcJiebaKeywordExtractor
- (instancetype)initWithDictPath: (NSString *)dicpath
                     hmmFilePath: (NSString *)hmmPath
                         idfPath: (NSString *)idfPath
                    stopWordPath: (NSString *)stopWordPath
                        userDict: (NSString *)userDict {
    self = [super init];
    
    if (dicpath == nil || dicpath.length == 0) {
        dicpath = [[self bunldePath] stringByAppendingPathComponent:@"ObjcJieba.bundle/dict/jieba.dict.utf8"];
    }
    
    if (hmmPath == nil || hmmPath.length == 0) {
        hmmPath = [[self bunldePath] stringByAppendingPathComponent:@"ObjcJieba.bundle/dict/hmm_model.utf8"];
    }
    
    if (idfPath == nil || idfPath.length == 0) {
        idfPath = [[self bunldePath] stringByAppendingPathComponent:@"ObjcJieba.bundle/dict/idf.utf8"];
    }
    
    if (stopWordPath == nil || stopWordPath.length == 0) {
        stopWordPath = [[self bunldePath] stringByAppendingPathComponent:@"ObjcJieba.bundle/dict/stop_words.utf8"];
    }
    
    if (userDict == nil || userDict.length == 0) {
        userDict = [[self bunldePath] stringByAppendingPathComponent:@"ObjcJieba.bundle/dict/user.dict.utf8"];
    }
    
    self.extractor = new cppjieba::KeywordExtractor([dicpath cStringUsingEncoding: NSUTF8StringEncoding],
                                                    [hmmPath cStringUsingEncoding: NSUTF8StringEncoding],
                                                    [idfPath cStringUsingEncoding: NSUTF8StringEncoding],
                                                    [stopWordPath cStringUsingEncoding: NSUTF8StringEncoding],
                                                    [userDict cStringUsingEncoding: NSUTF8StringEncoding]);
    
    return self;
}

- (NSString *)bunldePath {
    static NSString *path = nil;
    if (path == nil) {
        path = [[NSBundle bundleForClass:[self class]] bundlePath];
    }
    return path;
}

- (void)dealloc {
    if (self.extractor) {
        delete self.extractor;
    }
}

- (void)extract:(NSString *)str completion:(void (^)(NSArray<ObjcJiebaKeywordExtractorResult *>*, NSError *))completion {
    if (str == nil || str.length == 0) {
        if (completion) {
            completion(@[], nil);
        }
        return;
    }
    const size_t topk = 5;
    std::vector<cppjieba::KeywordExtractor::Word> keywordres;
    self.extractor->Extract([str cStringUsingEncoding:NSUTF8StringEncoding], keywordres, topk);
    
    NSMutableArray<ObjcJiebaKeywordExtractorResult *> *results = [NSMutableArray new];
    for(auto const& value: keywordres) {
        ObjcJiebaKeywordExtractorResult *result = [ObjcJiebaKeywordExtractorResult new];
        result.word = [[NSString alloc] initWithUTF8String:value.word.c_str()];
        
        if (value.offsets.size() > 0) {
            result.range = NSMakeRange(value.offsets[0], result.word.length);
        }
        result.weight = value.weight;
        [results addObject: result];
    }
    completion(results, nil);
}
@end
