//
//  HVFUSViewController.m
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/27/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import "HVFUSViewController.h"
#import "HVAddSentViewController.h"
#import "HVSentence.h"

@interface HVFUSViewController (){
    NSMutableArray *_list;
    HVSentence * _sentence;
    HVAddSentViewController *_addSentenceView;
}
@end

@implementation HVFUSViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"常用语"];

    _sentence = [HVSentence alloc];
    [_sentence initDB];
    _list = [_sentence getSentencesList];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //添加按钮
    UIBarButtonItem * _addbutton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(onAddSentenceBegin:)];
    self.navigationItem.rightBarButtonItem = _addbutton;
    
    //用Noti接受新增句子-----------------------------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddSentenceEnd:) name:@"addSentence" object:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)onAddSentenceBegin:(id)sender{
    NSLog(@"addBegin");
    _addSentenceView = [[HVAddSentViewController alloc] init];
    [self.navigationController presentViewController:_addSentenceView animated:true completion:nil];
}

-(void)onAddSentenceEnd:(NSNotification *) notification{
    NSLog(@"addEnd");
    [_sentence addSentence:[notification object]];
    _list = [_sentence getSentencesList];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_list count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    cell.textLabel.text = [_list objectAtIndex:row];

    // Configure the cell...
    return cell;
}

//发送通知，告知被选中列得文字
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"incertSentence" object:[_list objectAtIndex:row]];//发送句子

    [self.navigationController popViewControllerAnimated:TRUE];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [_sentence removeSentence:[_list objectAtIndex:indexPath.row]];
        _list = [_sentence getSentencesList];
        [self.tableView reloadData];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
