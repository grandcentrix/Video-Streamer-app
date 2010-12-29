#import "RootViewController.h"
#import "UpnpServer.h"


@interface RootViewController ()
@property (nonatomic, retain) DirectoryWatcher *directoryWatcher;
@property (nonatomic, retain) NSMutableArray *documentUrls;
@end


@implementation RootViewController

@synthesize aboutViewController = aboutViewController_;
@synthesize instructionsViewController = instructionsViewController_;
@synthesize filesViewController = filesViewController_;
@synthesize directoryWatcher = directoryWatcher_;
@synthesize documentUrls = documentUrls_;


#pragma mark -
#pragma mark RootViewController

- (void)dealloc
{
    [aboutViewController_ release];
    [instructionsViewController_ release];
    [filesViewController_ release];
    [directoryWatcher_ release];
    [documentUrls_ release];
    
    [super dealloc];
}

-(IBAction)switchInfo:(id)sender
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.25];
//    [UIView setAnimationBeginsFromCurrentState:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.containerView cache:YES];
//    
//	// If the info view is hidden, hide other views and show
//    if (self.infoView.hidden)
//    {
//        self.infoView.hidden = NO;
//        self.addFromiTunesView.hidden = YES;
//        self.tableView.hidden = YES;
//    }
//    // If switching from hidden view, determine which view to show based on if 
//    // files in directory
//    else
//    {
//        [self directoryDidChange:self.directoryWatcher];
//    }
//    
//    [UIView commitAnimations];
}


#pragma mark -
#pragma mark DirectoryWatcherDelegate

- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher
{
	[self.documentUrls removeAllObjects];	
    
    NSArray *files = [UpnpServer documentsDirectoryContents];
    if (files == nil || [files count] == 0)
    {
        if (self.instructionsViewController == nil)
        {
            InstructionsViewController *instructionsViewController = [[InstructionsViewController alloc] initWithNibName:@"InstructionsView-iPhone" bundle:nil];
            self.instructionsViewController = instructionsViewController;
            [instructionsViewController release];
        }
        
        [self.view addSubview:self.instructionsViewController.view];
        
//        self.infoView.hidden = YES;
//        self.addFromiTunesView.hidden = NO;
//        self.tableView.hidden = YES;
    }
    else
    {        
        // Iterates through all files in the Documents directory
        for (NSString* file in [files objectEnumerator])
        {
            NSString *filePath = [[UpnpServer filePath] stringByAppendingPathComponent:file];
            NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
            
            BOOL isDirectory;
            [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            // Add the document URL to our list (ignore the "Inbox" folder)
            if (!(isDirectory && [file isEqualToString: @"Inbox"]))
            {
                [self.documentUrls addObject:fileUrl];
            }
        }
        
//        [self.tableView reloadData];
//        
//        self.infoView.hidden = YES;
//        self.addFromiTunesView.hidden = YES;
//        self.tableView.hidden = NO;
    }
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Start monitoring the document directory
    NSMutableArray *documentUrls = [[NSMutableArray alloc] init];
    self.documentUrls = documentUrls;
    [documentUrls release];
    self.directoryWatcher = [DirectoryWatcher watchFolderWithPath:[UpnpServer filePath] delegate:self];
    
    // Switch views based on if files in directory
    [self directoryDidChange:self.directoryWatcher];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Supports all orientations
    return YES;
}

@end
