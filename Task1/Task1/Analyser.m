#import "Analyser.h"

@implementation Analyser

-(void)foo:(NSString *)bar{
    NSMutableDictionary *statistics=[NSMutableDictionary new];
    
    NSArray *words=[bar componentsSeparatedByString:@" "];
    for(NSString *word in words){
        NSNumber *repetitions = [statistics valueForKey:word];
        
        [statistics setObject:[[NSNumber alloc] initWithLong:([repetitions integerValue] + 1)] forKey:word];
    }
    
    NSArray *sortedKeys = [statistics keysSortedByValueUsingComparator:^NSComparisonResult(id x1, id x2) {
        if([x1 integerValue]>[x2 integerValue])
            return NSOrderedAscending;
        if([x1 integerValue] < [x2 integerValue])
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
    
    for(int i=0; i<[sortedKeys count]; i++)
        NSLog(@"%@ %@", sortedKeys[i], [statistics valueForKey:sortedKeys[i]]);
}

@end
