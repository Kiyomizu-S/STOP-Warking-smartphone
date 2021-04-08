//
//  Briding-Header.h
//  STOP!!歩きスマホ!
//
//  Created by 清水直輝 on 2016/08/07.
//  Copyright © 2016年 清水直輝. All rights reserved.
//

#ifndef Briding_Header_h
#define Briding_Header_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "FMDatabasePool.h"
#import "sqlite3.h"

extern bool hantei = false;
extern CGFloat centerX = 0;
extern CGFloat centerY = 0;

@interface Detector: NSObject

- (id)init;
- (UIImage *)recognizeFace:(UIImage *)image;
@end

#endif /* Briding_Header_h */
