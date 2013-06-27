//
//  LookAhead.m
//  pegged
//
//  Created by Matt Diephouse on 1/1/10.
//  This code is in the public domain.
//

#import "LookAhead.h"

#import "Compiler.h"

@implementation LookAhead

@synthesize node = _node;

//==================================================================================================
#pragma mark -
#pragma mark Node Methods
//==================================================================================================

- (NSString *) compile:(NSString *)parserClassName
{
    NSMutableString *code = [NSMutableString string];
    
    [code appendFormat:@"if (![parser lookAheadWithCaptures:localCaptures block:^(%@ *parser, NSInteger *localCaptures){\n", parserClassName];
    [code appendString:[[[self.node compile:parserClassName] stringIndentedByCount: 1] stringByRemovingTrailingWhitespace]];
    [code appendString:@"\n\n\treturn YES;\n"];
    [code appendString:@"}])\n\treturn NO;\n"];
    
    return code;
}


//==================================================================================================
#pragma mark -
#pragma mark Public Methods
//==================================================================================================

+ (id) lookAheadWithNode:(Node *)node
{
    return [[[self class] alloc] initWithNode:node];
}


- (id) initWithNode:(Node *)node
{
    self = [super init];
    
    if (self)
    {
        _node = node;
    }
    
    return self;
}


@end
