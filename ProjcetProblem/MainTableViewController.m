//
//  MainTableViewController.m
//  ProjectProblem
//
//  Created by Michael on 11/3/15.
//  Copyright © 2015 Michael. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@property (nonatomic,strong) NSMutableArray *fileList;


@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self populateFileList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.fileList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *filename = self.fileList[indexPath.row];
    
    NSString *ext = [filename pathExtension];
    
    if ([ext isEqualToString:@"plist"]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    if ([ext isEqualToString:@"png"]) {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    if ([ext isEqualToString:@"jpg"]) {
        cell.textLabel.textColor = [UIColor greenColor];
    }
    if ([ext isEqualToString:@"xcassets"]) {
        cell.textLabel.textColor = [UIColor yellowColor];
    }
    if ([ext isEqualToString:@"storyboardc"]) {
        cell.textLabel.textColor = [UIColor purpleColor];
    }
    if ([ext isEqualToString:@""]) {
        cell.textLabel.textColor = [UIColor cyanColor];
    }

    cell.textLabel.text = filename;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.subpath == nil) {
        self.subpath = @"";
    }
    
    NSString *append = self.fileList[indexPath.row];
    NSString *newPath = [NSString stringWithFormat:@"%@/%@",self.subpath,append];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTableViewController * controller = [storyboard instantiateViewControllerWithIdentifier:@"fileTable"];
    controller.subpath = newPath;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
    // log every file that i browse
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"fileLog"];
    NSString *logLine = [NSString stringWithFormat:@"%@\n\r",self.subpath];
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:appFile];
    if (!fileHandler) {
        [[NSFileManager defaultManager] createFileAtPath:appFile contents:nil attributes:nil];
        fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:appFile];
    }
    [fileHandler seekToEndOfFile];
    [fileHandler writeData:[logLine dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandler closeFile];
}

#pragma mark - Helper methods

- (void)populateFileList {
    
    if (!self.subpath) {
        self.subpath = [[NSBundle mainBundle] bundlePath];
    }
    
    self.fileList = [NSMutableArray new];
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.subpath error:NULL];
    
    [directoryContent enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"File %lu: %@", (idx + 1), [directoryContent objectAtIndex:idx]);
        
        [self.fileList addObject:[directoryContent objectAtIndex:idx]];
        
    }];
}

@end
