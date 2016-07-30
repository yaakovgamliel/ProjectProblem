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
    
    int count;
    
    if (self.subpath == nil) {
        self.subpath = [[NSBundle mainBundle] bundlePath];
    }
    

    self.fileList = [NSMutableArray new];
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.subpath error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        [self.fileList addObject:[directoryContent objectAtIndex:count]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
