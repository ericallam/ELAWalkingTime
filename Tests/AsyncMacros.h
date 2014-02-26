//
//  AsyncMacros.h
//  ELAWalkingTime Tests
//
//  Created by Eric Allam on 26/02/2014.
//  Copyright (c) 2014 Eric Allam. All rights reserved.
//

#ifndef ELAWalkingTime_Tests_AsyncMacros_h
#define ELAWalkingTime_Tests_AsyncMacros_h

// Macro - Set the flag for block completion
#define StartBlock() __block BOOL waitingForBlock = YES

// Macro - Set the flag to stop the loop
#define EndBlock() waitingForBlock = NO

// Macro - Wait and loop until flag is set
#define WaitUntilBlockCompletes() WaitWhile(waitingForBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
// Each test should have its own instance of a BOOL condition because of non-thread safe operations
#define WaitWhile(condition) \
do { \
while(condition) { \
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
} \
} while(0)

#endif
