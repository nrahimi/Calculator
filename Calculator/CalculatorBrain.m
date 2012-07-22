//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Navid Rahimi on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack{
    if (! _operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    
    return _operandStack;
}

- (void) pushOperand:(double)operand{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];

    [self.operandStack addObject:operandObject];
 
}

- (double) popOperand{
    NSNumber * operandObject = [self.operandStack lastObject];
    
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (double) performOperation:(NSString *)operation{
    double result = 0;
    
    //perform operation here and store answer in result
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
        
    }else if( [operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    }else if( [operation isEqualToString:@"-"]){
       double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }else if( [operation isEqualToString:@"/"]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }else if ( [operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    }else if ( [operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    }else if ( [operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    }else if ( [operation isEqualToString:@"π"]){
        result = M_PI;
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)clearStack{
    [self.operandStack removeAllObjects];
}

@end
