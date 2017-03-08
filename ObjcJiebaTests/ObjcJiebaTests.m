//
//  ObjcJiebaTests.m
//  ObjcJiebaTests
//
//  Created by admin on 08/03/2017.
//  Copyright © 2017 none. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ObjcJieba/ObjcJieba.h>

@interface ObjcJiebaTests : XCTestCase
@property (nonatomic, strong) ObjcJiebaKeywordExtractor *extractor;
@end

@implementation ObjcJiebaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.extractor = [[ObjcJiebaKeywordExtractor alloc] initWithDictPath:nil hmmFilePath:nil idfPath:nil stopWordPath:nil userDict:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.extractor = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *str = @"与三星抢苹果订单 夏普投资生产OLED屏幕";
    [self.extractor extract:str completion:^(NSArray<ObjcJiebaKeywordExtractorResult *> *results, NSError *error) {
        if (error) {
            return;
        }
        
        for (ObjcJiebaKeywordExtractorResult *result in results) {
            NSLog(@"result: %@", result.debugDescription);
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
