//
//  CalculatorBrain.m
//  Lecture_2_MyFirstiOSAPP
//
//  Created by Yoyo_Chen on 9/28/12.
//  Copyright (c) 2012 Yoyo_Chen. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray*) operandStack
{
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void) setOperandStack:(NSMutableArray *)operandStack;
{
    _operandStack = operandStack;
}

- (void) pushOperand:(double) operand {
    //remember to check the opperandStack pointer's availability
    //Q1: synthesize doesn't do anymore allocate
    //Q2: If I don't use nonatomic ,what would happen?
    // it would get a warning 
    [[self operandStack] addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double) popOperand {
    NSNumber *operandObject = [[self operandStack] lastObject];
    if (operandObject) {
        [[self operandStack] removeLastObject];
    }
    return [operandObject doubleValue];
}

- (double) performOperation:(NSString *)operation {
    double result = 0;
    
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) {
        result = [self popOperand] / divisor;
        }
    } else if ([operation isEqualToString:@"Sin"]){
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"Cos"]){
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"Sqrt"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"Pi"]){
        result = [self popOperand] * M_PI;
    }
    
    [self pushOperand:result];
    return result;
}

- (void) dealloc {
    [[self operandStack] removeAllObjects];    
}
@end
