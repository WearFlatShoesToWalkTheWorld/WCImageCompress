//
//  UIImage+Wechat.h
//
//  Created by tiger on 2017/2/21.
//  Copyright © 2017年 xinma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Wechat)

/**
 use session compress Strategy
 */
- (UIImage *)wcSessionCompress;

/**
 use timeline compress Strategy
 */
- (UIImage *)wcTimelineCompress;

@end
