//
//  TestView.m
//  Sawasdee
//
//  Created by BooBoo on 8/6/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "TestView.h"

@implementation TestView

//static const CGFloat kPadding = 4.f;
//static const CGFloat kLabelFontSize = 16.f;
//static const CGFloat kDetailsLabelFontSize = 12.f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UIFont *font;
    int labelPositionY = 0;
    if(IS_IPAD){
        labelPositionY = 16*(frame.size.height/16);
         font = ThemeFontNormalDiff(1);
    }else{
        labelPositionY = 15*(frame.size.height/16);
         font = ThemeFontNormalDiff(-3);
    }
    self.backgroundColor = [UIColor clearColor];
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-27, labelPositionY, 40, 30)];
    timeLabel.font = font;
    timeLabel.text = @"";
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview: timeLabel];
    
    //[NSTimeZone defaultTimeZone];

    timeZone = [NSTimeZone defaultTimeZone];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame forLocale:(NSString *)locale
{
    self = [super initWithFrame:frame];
    
    locale = @"Asia/Bangkok";
    UIFont *font;
    int labelPositionY  = 0;
    if(IS_IPAD){
        labelPositionY = 16*(frame.size.height/16);
        font = ThemeFontNormalDiff(1);
    }else{
        labelPositionY = 15*(frame.size.height/16);
        font = ThemeFontNormalDiff(-3);
    }
    self.backgroundColor = [UIColor clearColor];
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-27, labelPositionY, 40, 30)];
    timeLabel.font = font;
    timeLabel.text = @"";
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: timeLabel];
    
    timeZone = [NSTimeZone timeZoneWithName:locale];
    return self;
}

- (void) updateClockView
{
    [self setNeedsDisplay];
}

#pragma mark - Layout
//
//- (void)layoutSubviews {
//	
//    float opacity = 0.8f;
//    UIColor *color = nil;
//    UIFont *labelFont = [UIFont boldSystemFontOfSize:kLabelFontSize];
//    UIColor *labelColor = [UIColor whiteColor];
//    UIFont *detailsLabelFont = [UIFont boldSystemFontOfSize:kDetailsLabelFontSize];
//    UIColor *detailsLabelColor = [UIColor whiteColor];
//    float xOffset = 0.0f;
//    float yOffset = 0.0f;
//    float dimBackground = NO;
//    float margin = 20.0f;
//    float cornerRadius = 10.0f;
//    float graceTime = 0.0f;
//    float minShowTime = 0.0f;
//    BOOL removeFromSuperViewOnHide = NO;
//    CGSize minSize = CGSizeZero;
//    BOOL square = NO;
//    BOOL annular = YES;
//    float progress = 0.f;
//
//    
//	// Entirely cover the parent view
//	UIView *parent = self.superview;
//	if (parent) {
//		self.frame = parent.bounds;
//	}
//	CGRect bounds = self.bounds;
//	
//	// Determine the total widt and height needed
//	CGFloat maxWidth = bounds.size.width - 4 * margin;
//	CGSize totalSize = CGSizeZero;
//	
//	CGRect indicatorF = indicator.bounds;
//	indicatorF.size.width = MIN(indicatorF.size.width, maxWidth);
//	totalSize.width = MAX(totalSize.width, indicatorF.size.width);
//	totalSize.height += indicatorF.size.height;
//	
//	CGSize labelSize = MB_TEXTSIZE(label.text, label.font);
//	labelSize.width = MIN(labelSize.width, maxWidth);
//	totalSize.width = MAX(totalSize.width, labelSize.width);
//	totalSize.height += labelSize.height;
//	if (labelSize.height > 0.f && indicatorF.size.height > 0.f) {
//		totalSize.height += kPadding;
//	}
//    
//	CGFloat remainingHeight = bounds.size.height - totalSize.height - kPadding - 4 * margin;
//	CGSize maxSize = CGSizeMake(maxWidth, remainingHeight);
//	CGSize detailsLabelSize = MB_MULTILINE_TEXTSIZE(detailsLabel.text, detailsLabel.font, maxSize, detailsLabel.lineBreakMode);
//	totalSize.width = MAX(totalSize.width, detailsLabelSize.width);
//	totalSize.height += detailsLabelSize.height;
//	if (detailsLabelSize.height > 0.f && (indicatorF.size.height > 0.f || labelSize.height > 0.f)) {
//		totalSize.height += kPadding;
//	}
//	
//	totalSize.width += 2 * margin;
//	totalSize.height += 2 * margin;
//	
//	// Position elements
//	CGFloat yPos = round(((bounds.size.height - totalSize.height) / 2)) + margin + yOffset;
//	CGFloat xPos = xOffset;
//	indicatorF.origin.y = yPos;
//	indicatorF.origin.x = round((bounds.size.width - indicatorF.size.width) / 2) + xPos;
//	indicator.frame = indicatorF;
//	yPos += indicatorF.size.height;
//	
//	if (labelSize.height > 0.f && indicatorF.size.height > 0.f) {
//		yPos += kPadding;
//	}
//	CGRect labelF;
//	labelF.origin.y = yPos;
//	labelF.origin.x = round((bounds.size.width - labelSize.width) / 2) + xPos;
//	labelF.size = labelSize;
//	label.frame = labelF;
//	yPos += labelF.size.height;
//	
//	if (detailsLabelSize.height > 0.f && (indicatorF.size.height > 0.f || labelSize.height > 0.f)) {
//		yPos += kPadding;
//	}
//	CGRect detailsLabelF;
//	detailsLabelF.origin.y = yPos;
//	detailsLabelF.origin.x = round((bounds.size.width - detailsLabelSize.width) / 2) + xPos;
//	detailsLabelF.size = detailsLabelSize;
//	detailsLabel.frame = detailsLabelF;
//	
//	// Enforce minsize and quare rules
//	if (square) {
//		CGFloat max = MAX(totalSize.width, totalSize.height);
//		if (max <= bounds.size.width - 2 * margin) {
//			totalSize.width = max;
//		}
//		if (max <= bounds.size.height - 2 * margin) {
//			totalSize.height = max;
//		}
//	}
//	if (totalSize.width < minSize.width) {
//		totalSize.width = minSize.width;
//	}
//	if (totalSize.height < minSize.height) {
//		totalSize.height = minSize.height;
//	}
//	
//	self.size = totalSize;
//}



- (void)drawRect:(CGRect)rect
{

    
//    float opacity = 0.8f;
//    UIColor *color = nil;
//    UIFont *labelFont = [UIFont boldSystemFontOfSize:kLabelFontSize];
//    UIColor *labelColor = [UIColor whiteColor];
//    UIFont *detailsLabelFont = [UIFont boldSystemFontOfSize:kDetailsLabelFontSize];
//    UIColor *detailsLabelColor = [UIColor whiteColor];
//    float xOffset = 0.0f;
//    float yOffset = 0.0f;
//    float dimBackground = NO;
//    float margin = 20.0f;
//    float cornerRadius = 10.0f;
//    float graceTime = 0.0f;
//    float minShowTime = 0.0f;
//    BOOL removeFromSuperViewOnHide = NO;
//    CGSize minSize = CGSizeZero;
//    BOOL square = NO;
//    BOOL annular = NO;
    float progress = 0.5f;
    
    UIColor *progressTintColor = [[UIColor alloc] initWithWhite:1.f alpha:1.f];
    UIColor *backgroundTintColor = [[UIColor alloc] initWithWhite:1.f alpha:.1f];
    UIColor *testTintColor = [[UIColor alloc] initWithWhite:0.5f alpha:.1f];
    
    CGRect allRect = self.bounds;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:~ NSTimeZoneCalendarUnit fromDate:[NSDate date]];
    [dateComponents setTimeZone:timeZone];
    
    float minutes = dateComponents.minute;
    float hours = dateComponents.hour;
    
    timeLabel.text = [NSString stringWithFormat:@"%2d:%2d", (int)hours, (int)minutes];
//    NSLog(@"Hour: %f, Minute:%f", hours, minutes);
    
    // minute angle
    CGFloat minuteAngle = minutes/60.0 *360;
    CGFloat minuteRadian =  DEGREES_TO_RADIANS( minuteAngle );
    
    // hour angle
    CGFloat hourAngle = ( (float) ((int)hours%12))/12.0 *360  + minutes/60*30;
    CGFloat hourRadian = DEGREES_TO_RADIANS( hourAngle );
    
    
	CGRect circleRect = CGRectInset(allRect, 2.0f, 2.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
    
    {
        // clock background

        [testTintColor setStroke];
        [testTintColor setFill];
        CGContextSetLineWidth(context, 2.0f);
        CGContextFillEllipseInRect(context, circleRect);
        CGContextStrokeEllipseInRect(context, circleRect);
        // Draw progress
        CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
        CGFloat radius = (allRect.size.width - 4) / 2;
        CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
        CGFloat endAngle = (1.5 * 2 * (float)M_PI) + startAngle;
        CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 0.2f); // white
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle+startAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }

    {
        // Minute
        //progress = minutes/24.0;
        // Draw background
        [testTintColor setStroke];
        [testTintColor setFill];
        CGContextSetLineWidth(context, 2.0f);
        CGContextFillEllipseInRect(context, circleRect);
        CGContextStrokeEllipseInRect(context, circleRect);
        // Draw progress
        CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
        CGFloat radius = (allRect.size.width - 4) / 2;
        CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
        CGContextSetRGBFillColor(context, 0.7f, 0.7f, 0.7f, 0.3f); // white
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, radius, startAngle, minuteRadian+startAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
    
    {
        
        
        // Hour
        //progress = hours/24.0;
        
        // Draw background
        [progressTintColor setStroke];
        [backgroundTintColor setFill];
        CGContextSetLineWidth(context, 2.0f);
        CGContextFillEllipseInRect(context, circleRect);
        CGContextStrokeEllipseInRect(context, circleRect);
        // Draw progress
        CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
        CGFloat radius = (allRect.size.width/3 - 4) / 2;
        CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
//        CGFloat endAngle = (progress * 2 * (float)M_PI) + startAngle;
        CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 0.5f); // white
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, radius, startAngle, hourRadian+startAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
	
    {
        // Minute
        //progress = minutes/24.0;
        // Draw background
        CGFloat lineWidth = 6.f;
        
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        CGFloat radius = (self.bounds.size.width/1.5 - lineWidth)/2;
        
        
        // minute angle
        CGFloat rotateAngle = minutes/60.0 *360;
        CGFloat rad_angle =  DEGREES_TO_RADIANS( rotateAngle );
        
//        NSLog(@"Minute Angle :%f, Radian: %f", rotateAngle, rad_angle);
//        NSLog(@"Minute sin:%f , cos:%f", radius*sin(rad_angle), radius*cos(rad_angle));
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, lineWidth);
        CGPoint point = CGPointMake( center.x + radius*sin(rad_angle), center.y - radius*(cos(rad_angle))  );
        CGContextMoveToPoint(context, center.x, center.y);    // This sets up the start point
        CGContextAddLineToPoint(context, point.x, point.y);   // This moves to the end point.
        CGContextStrokePath(context);
    }
    
    
    {
        // Hour
        //progress = hours/24.0;
        // Draw background
        CGFloat lineWidth = 10.f;
        
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        CGFloat radius = (self.bounds.size.width/2 - lineWidth)/2;
        
        // hour angle
        CGFloat rotateAngle = ((float)((int)hours%12))/12.0 *360  + minutes/60*30;
        CGFloat rad_angle = DEGREES_TO_RADIANS(rotateAngle);
        
//        NSLog(@"Hour Angle :%f, Radian: %f", rotateAngle, rad_angle);
//        NSLog(@"Hour sin:%f , cos:%f", radius*sin(rad_angle), radius*cos(rad_angle));
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, lineWidth);
        CGPoint point = CGPointMake( center.x + radius*sin(rad_angle), center.y - radius*(cos(rad_angle))  );
        CGContextMoveToPoint(context, center.x, center.y);    // This sets up the start point
        CGContextAddLineToPoint(context, point.x, point.y); // This moves to the end point.
        CGContextStrokePath(context);
    }
    
    
    
    // Draw time mark
    for(int i=0; i<12; i++){
    {
        CGContextSaveGState(context);
        float width = 5;
        float height = 15;
        if(IS_IPAD_UI()){
            width = 10;
            height = 20;
        }
        CGFloat lineWidth = 1.f;
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        CGFloat halfWidth = width / 2.0;
        CGFloat halfHeight = height / 2.0;
        
        CGFloat radius = (allRect.size.width - 4) / 2;
        CGFloat endAngle = (float)i/12.0 *360;
        CGFloat radian_angle = DEGREES_TO_RADIANS(endAngle);
        CGPoint point = CGPointMake( center.x + radius*sin(radian_angle), center.y + radius*(cos(radian_angle))  );
        
        // Move to the center of the rectangle:
        CGContextTranslateCTM(context, point.x, point.y);
        // Rotate:
        CGContextRotateCTM(context, i*DEGREES_TO_RADIANS(360-30));
        
        // Draw the rectangle centered about the center:
        CGRect rect = CGRectMake(-halfWidth, -halfHeight, width, height);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, lineWidth);
        CGContextAddRect(context, rect);
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);
    }
	//UIGraphicsPopContext();
    
    }
    
    UIGraphicsPopContext();
    
}
@end

