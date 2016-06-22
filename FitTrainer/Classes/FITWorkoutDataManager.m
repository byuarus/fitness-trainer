//
//  FITWorkoutDataManager.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITWorkoutDataManager.h"
#import "FITWorkoutDefaults.h"

@implementation FITWorkoutDataManager
static NSUInteger localVersion;


+ (id)instance {
    static FITWorkoutDataManager *instanceDataManager = nil;
    @synchronized(self) {
        if (instanceDataManager == nil)
            instanceDataManager = [[self alloc] init];
    }
    return instanceDataManager;
}

- (id)init {
    if (self = [super init]) {
        [self loadFromLocalStorage];
        [self checkForUpdatesOnServer];
    }
    
    return self;
}


- (void)loadFromLocalStorage {
    NSDictionary *savedWorkouts = [self getSavedWorkoutData];
    
    if (!savedWorkouts) {
        [self loadDefaultWorkoutsTemplate];
        return;
    }
    
    [self initWorkoutDataWithDictionary:savedWorkouts];
}


- (void)loadDefaultWorkoutsTemplate {
    NSString *filePath =[[NSBundle mainBundle] pathForResource:@"WorkoutTemplate" ofType:@"json"];
    NSError *errorReadingFile;
    NSString *fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&errorReadingFile];
    
    if (errorReadingFile) {
        NSLog(@"ERROR:Error reading file: %@",errorReadingFile.localizedDescription);
        return;
    }
    
    NSError *errorParsingJson;
    NSDictionary* workoutsTemplate = (NSDictionary *)[NSJSONSerialization
                                                      JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                                      options:0 error:&errorParsingJson];
    if (errorParsingJson) {
        NSLog(@"ERROR:Error parsing json file: %@",errorParsingJson.localizedDescription);
        return;
    }
    [self initWorkoutDataWithDictionary:workoutsTemplate];
}


- (void)initWorkoutDataWithDictionary:(NSDictionary *) WorkoutDataDictionary {
    localVersion = [[WorkoutDataDictionary objectForKey:@"version"] intValue];
    self.workoutList = [WorkoutDataDictionary objectForKey:@"Workouts"];
    FITWorkoutDefaults *workoutDefaults = [FITWorkoutDefaults instance];
    NSDictionary *defaultsDictionary = [WorkoutDataDictionary objectForKey:@"Defaults"];
    [workoutDefaults updateWithDictionary:defaultsDictionary];
}


- (void)checkForUpdatesOnServer {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *receiveVersionTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://api.myjson.com/bins/5010v"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *serverError) {
        if (serverError) {
           NSLog(@"ERROR: Cannot receive data version from server. Detailes: %@", serverError);
           return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if (localVersion < [json[@"version"] intValue]) {
            [self updateWorkoutDataFromServer];
        }
    }];
    [receiveVersionTask resume];
}


- (void)updateWorkoutDataFromServer {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *receiveWorkoutDataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://api.myjson.com/bins/2i0a7"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *serverError)
    {
        if (serverError) {
            NSLog(@"ERROR: Cannot receive Workout Data from server. Detailes: %@", serverError);
            return;
        }
        
        NSError *errorParsingJsonFromServer;
        NSDictionary *wokoutDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&errorParsingJsonFromServer];
        
        if (errorParsingJsonFromServer) {
            NSLog(@"ERROR: Error parsing json with Workout Data file from server: %@",errorParsingJsonFromServer.localizedDescription);
            return;
        }
        
        [self saveWorkoutDataWithDictionary:wokoutDataDictionary];
        [self initWorkoutDataWithDictionary:wokoutDataDictionary];
    }];
    [receiveWorkoutDataTask resume];
}


- (void)saveWorkoutDataWithDictionary:(NSDictionary *)dictionary {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *jsonPath=[[paths objectAtIndex:0] stringByAppendingFormat:@"/workoutData.json"];
    [dictionary writeToFile:jsonPath atomically:YES];
}


- (NSDictionary *)getSavedWorkoutData {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *jsonPath=[[paths objectAtIndex:0] stringByAppendingFormat:@"/workoutData.json"];
    
    if (![fileManager fileExistsAtPath:jsonPath]) {
        return nil;
    }
    
    NSError *errorParsingJson;
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:jsonPath];
    
    if (errorParsingJson) {
        NSLog(@"ERROR: Error parsing json from local storage: %@",errorParsingJson.localizedDescription);
        return nil;
    }
    
    return dictionary;
}

@end





















