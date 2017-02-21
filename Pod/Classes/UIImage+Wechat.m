//
//  UIImage+Wechat.m
//
//  Created by tiger on 2017/2/21.
//  Copyright © 2017年 xinma. All rights reserved.
//

#import "UIImage+Wechat.h"

@implementation UIImage (Wechat)

- (UIImage *)wcSessionCompress {
    return [self wcCompres:YES];
}

- (UIImage *)wcTimelineCompress {
    return [self wcCompres:NO];
}

/**
 wechat image compress
 
 @param isSession session image boundary is 800, timeline is 1280
 
 @return thumb image
 */
- (UIImage *)wcCompres:(Boolean)isSession {
    CGSize size = [self wxImageSize:isSession];
    UIImage *reImage = [self resizedImage:size];
    NSData *data = UIImageJPEGRepresentation(reImage, 0.5);
    return [[UIImage alloc] initWithData:data];
}


/**
 get wechat compress image size

 @return thumb image size
 */
- (CGSize)wxImageSize:(Boolean)isSession {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat boundary = 1280;
    
    // width, height <= 1280, Size remains the same
    if (width < boundary && height < boundary) {
        return CGSizeMake(width, height);
    }
    
    // aspect ratio
    CGFloat ratio = MAX(width, height) / MIN(width, height);
    if (ratio <= 2) {
        CGFloat x = MAX(width, height) / boundary;
        if (width > height) {
            width = boundary;
            height = height / x;
        } else {
            height = boundary;
            width = width / x;
        }
    } else {
        // width, height > 1280
        if (MIN(width, height) >= boundary) {
            boundary = isSession ? 800 : 1280;
            // Set the smaller value to the boundary, and the larger value is compressed
            CGFloat x = MIN(width, height) / boundary;
            if (width < height) {
                width = boundary;
                height = height / x;
            } else {
                height = boundary;
                width = width / x;
            }
        }
    }

    return CGSizeMake(width, height);
}

/**
 Zoom the picture to the specified size
 
 @param newSize session image boundary is 800, timeline is 1280
 
 @return new image
 */
- (UIImage *)resizedImage:(CGSize)newSize {
    CGRect newRect = CGRectMake(0, 0, newSize.width, newSize.height);
    UIGraphicsBeginImageContext(newRect.size);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:self.CGImage scale:1 orientation:self. imageOrientation];
    [newImage drawInRect:newRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
