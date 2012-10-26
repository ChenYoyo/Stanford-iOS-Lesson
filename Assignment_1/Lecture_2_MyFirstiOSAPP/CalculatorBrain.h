//
//  CalculatorBrain.h
//  Lecture_2_MyFirstiOSAPP
//
//  Created by Yoyo_Chen on 9/28/12.
//  Copyright (c) 2012 Yoyo_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double) operand;
- (double) performOperation:(NSString *)operation;

/*
@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;
*/
@end
