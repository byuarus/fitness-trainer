
//
//  FITUIImageLoader.h
//  FitTrainer
//
//  Dowloaded from https://github.com/gngrwzrd/UIImageLoader.git
//  Edited by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <TargetConditionals.h>


#import <UIKit/UIKit.h>


/********************/
/* FITUIImageLoader */
/********************/

typedef UIImage FITUIImageLoaderImage;


//image source passed in completion callbacks.
typedef NS_ENUM(NSInteger,FITUIImageLoadSource) {
	
	//this is passed to callbacks when there's an error, no image is provided.
	FITUIImageLoadSourceNone,               //no image source as there was an error.
	
	//these will be passed to your hasCache callback
	FITUIImageLoadSourceDisk,               //image was cached on disk already and loaded from disk
	FITUIImageLoadSourceMemory,             //image was in memory cache
	
    //these will be passed to your requestCompleted callback
	FITUIImageLoadSourceNetworkNotModified, //a network request was sent but existing content is still valid
	FITUIImageLoadSourceNetworkToDisk,      //a network request was sent, image was updated on disk
	
};

//forward
@class FITUIImageMemoryCache;

//completion block
typedef void(^FITUIImageLoader_HasCacheBlock)(FITUIImageLoaderImage * image, FITUIImageLoadSource loadedFromSource);
typedef void(^FITUIImageLoader_SendingRequestBlock)(BOOL didHaveCachedImage);
typedef void(^FITUIImageLoader_RequestCompletedBlock)(NSError * error, FITUIImageLoaderImage * image, FITUIImageLoadSource loadedFromSource);

//error constants
extern NSString * const FITUIImageLoaderErrorDomain;
extern const NSInteger FITUIImageLoaderErrorResponseCode;
extern const NSInteger FITUIImageLoaderErrorContentType;
extern const NSInteger FITUIImageLoaderErrorNilURL;

//use the +defaultLoader or create a new one to customize properties.
@interface FITUIImageLoader : NSObject <NSURLSessionDelegate>

//memory cache where images get stored if cacheImagesInMemory is on.
@property FITUIImageMemoryCache * memoryCache;

//the session object used to download data.
//If you change this then you are responsible for implementing delegate logic for acceptsAnySSLCertificate if needed.
@property (nonatomic) NSURLSession * session;

//default location is in home/Library/Caches/my.bundle.id/UIImageLoader
@property (nonatomic) NSURL * cacheDirectory;

//accepted content types (default = @[@"image/png",@"image/jpg",@"image/jpeg",@"image/bmp",@"image/gif",@"image/tiff"]).
@property NSArray * acceptedContentTypes;

//whether to use server cache policy. Default is TRUE
@property BOOL useServerCachePolicy;

//if using server cache control, and the server doesn't return a Cache-Control max-age header, you can use this
//to provide your own max age for caching before the image is requested again.
@property NSTimeInterval defaultCacheControlMaxAge;

//Whether to trust any ssl certificate. Default is FALSE
@property BOOL trustAnySSLCertificate;

//whether to cache loaded images (from disk) into memory.
@property BOOL cacheImagesInMemory;

//Whether to NSLog image urls when there's a cache miss.
@property BOOL logCacheMisses;

//get the default configured loader.
+ (FITUIImageLoader *) defaultLoader;

//init with a disk cache url.
- (id) initWithCacheDirectory:(NSURL *) url;

//set the Authorization username/password. If set this gets added to every request. Use nil/nil to clear.
- (void) setAuthUsername:(NSString *) username password:(NSString *) password;

//these ignore cache policies and delete files where the modified date is older than specified amount of time.
- (void) clearCachedFilesModifiedOlderThan1Day;
- (void) clearCachedFilesModifiedOlderThan1Week;
- (void) clearCachedFilesModifiedOlderThan:(NSTimeInterval) timeInterval;

//these ignore cache policies and delete files where the created date is older than specified amount of time.
- (void) clearCachedFilesCreatedOlderThan1Day;
- (void) clearCachedFilesCreatedOlderThan1Week;
- (void) clearCachedFilesCreatedOlderThan:(NSTimeInterval) timeInterval;

//ignore cache policy and delete all disk cache files.
- (void) purgeDiskCache;

//purge the memory cache.
- (void) purgeMemoryCache;

//set memory cache max bytes.
- (void) setMemoryCacheMaxBytes:(NSUInteger) maxBytes;

//load an image with URL.
- (NSURLSessionDataTask *) loadImageWithURL:(NSURL *) url
								   hasCache:(FITUIImageLoader_HasCacheBlock) hasCache
								sendingRequest:(FITUIImageLoader_SendingRequestBlock) sendingRequest
						   requestCompleted:(FITUIImageLoader_RequestCompletedBlock) requestCompleted;

//load an image with custom request.
//auth headers will be added to your request if needed.
- (NSURLSessionDataTask *) loadImageWithRequest:(NSURLRequest *) request
									   hasCache:(FITUIImageLoader_HasCacheBlock) hasCache
									sendingRequest:(FITUIImageLoader_SendingRequestBlock) sendingRequest
							   requestCompleted:(FITUIImageLoader_RequestCompletedBlock) requestCompleted;

@end

/************************/
/** FITUIImageMemoryCache **/
/************************/

@interface FITUIImageMemoryCache : NSObject

//max cache size in bytes.
@property (nonatomic) NSUInteger maxBytes;

//cache an image with URL as key.
- (void) cacheImage:(FITUIImageLoaderImage *) image forURL:(NSURL *) url;

//remove an image with url as key.
- (void) removeImageForURL:(NSURL *) url;

//delete all cache data.
- (void) purge;

@end
