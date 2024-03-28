## 0.38.0
* Fix: Error of FeedType missmatched while creating the video story. Added ability to add FeedType while uploading video file 

## 0.37.0
* Feat: The post count for a community can be fetched on the basis of AmityFeedType by using AmityCommunity.getPostCount. 

## 0.36.0
* Feat: Video Story can be created using AmitySocialClient.newStoryRepository().createVideoStory.
* Feat: Image Story can be created using AmitySocialClient.newStoryRepository().createImageStory.
* Feat: StoryLiveCollection can be used to observe Active stories.


## 0.35.0
* Feat: Added Post Impression, now post can be marked as read using amityPost.analytics().markPostAsViewed(). Likewise post impression and reach can be get by using amityPost.impression and amityPost.reach
* Upgrade: Upgraded dart version from ">=2.15.1 <4.0.0" to ">=3.0.0 <4.0.0"
* Upgrade: Upgraded the dependencies except Socket as amity backend currently works on socket v2
* Fix: AmityFeedType filter not working on post live collection 


## 0.34.0
* Feat: Post Live Object can be used by AmitySocialClient.newPostRepository().live.getPost(postId)
* Feat: Post Live collection have been added
* Feat: Now user can get category by AmitySocialClient.newCommunityRepository().getCategory(categoryId)
* Feat: Now user can get global feed custom ranking by AmitySocialClient.newFeedRepository().getCustomRankingGlobalFeed()


## 0.33.0
* Feat: Upgraded, Upgradable libraries that would not cuase breaking changes
* Refactor: AmitySocialClient.newCommunityRepository().getCurentUserRoles is depercated in favor of AmitySocialClient.newCommunityRepository().getCurrentUserRoles 
* Fix: Crash when getting current user roles for community 
* Fix: Crash when getting reations of post

## 0.32.0
* Upgrade: amity_sdk_version

## 0.31.0
* Fix: Exception when scrolling through the posts
* Feat: Auto Subscribe to the the network

## 0.30.0
* Feat: Added Support for getting live and recorded streams
* Feat: Configuration for AmityVideoPlayer added as well

## 0.29.0
* Fix: Width and Height coming null for video

## 0.28.0
* Feat: Added tags option when creating new message
* Fix: removed flaggedByMe in favour of isFlaggedByme for users

## 0.27.0
* Feat: Added comminity user rolers in comments
* Fix: Now video upload give back the upload progress

## 0.26.0
* fix: File is now optional so in case if file for a post is deleted it will return nulll instead of crashing

## 0.25.0
* fix: Get Post by ID not working

## 0.24.0
* fix: DataType Filter is now working on user and community feeds


## 0.23.0
* fix: Member can be removed from community and live channel
* fix: iOS can not receive notifications
* feat: Updated Dio to version 5

## 0.21.0
* feat: Added create comment with Image
* feat: Added query comment with Image
* refactor: align function signature and namespace for Core module 
* refactor: align function signature and namespace for Social module 
* refactor: align function signature and namespace for Chat module 

## 0.20.0
* feat: Added user block/unblock
* feat: Added get blocked users
* fix: resolve issue with create commetn(Update comment count in post)

## 0.19.0
* feat: Added RTE event for Post topic
* feat: Added RTE event for Comment topic
* feat: Added RTE event for Channel topic
* feat: Added RTE event for Community topic

## 0.18.0
* feat: File uploading progress
* feat: Image uploading progress
* BREAKING FEAT: Updated Future Upload public API to Stream Upload API

## 0.17.1
* fix: resolve issue with community query delete flag

## 0.17.0
* feat: Community user search by keyword
* feat: Mention user in post creation
* feat: Mention user in comment creation
* fix: resolve issue with flag update

## 0.16.0
* feat: Global user search
* feat: Comunity User Search
* feat: Global user search sorting
* fix: Added amityuser avatar file in compose usecase

## 0.15.0
* feat: User mention in channel message
* feat: Channel mention in channel message
* feat: Channel message mention helper 
* feat: Channel member search 
* feat: isFlaggedByMe check for user
* fix: handled null check in live stream post

## 0.14.0
* feat: Reply to channel message
* feat: Flag/Unflag channel message
* feat: Flag/Unflag channel message sender
* feat: Add/Remove tags on channel message
* feat: Mute/Unmute channel from client side 
* fix: Added Amity Object extension method for reporting message and user

## 0.13.1
* fix: Resolve issue Amity Message Update Query Builder 

## 0.13.0
* feat: Channel Message Query & Filter
* feat: Channel Message Update
* feat: Channel Message Delete
* fix: Add tags support in v4/post query

## 0.12.0
* feat: Create/Update Channel
* feat: Mute/Unmute Channel Member 
* feat: Ban/Unban Channel Member 
* fix: Amity post my reaction after reaction update

## 0.11.0
* feat: Channel Member Add/Remove roles and permission
* feat: Check user perssion for channel
* fix: Channel Query filere validation
## 0.10.0
* feat: Channel Member Query
* fix: Update listner method for AmityChannelMember model
## 0.9.0
* feat: Channel Query
* feat: Get Channel By Id
* fix: resolve issue with Message RTE payload 
## 0.8.0
* feat: Create image/file message
* feat: Channel repo setup
* feat: Join/Leave channel
* feat: Add/Remove message reactions
* feat: Message reactions query
* fix: change live collection stream to stream controller
* fix: Error handling in live collection
## 0.7.0
* feat: Create and Query Chat Message  
* feat: Chat Message Live Collection
* feat: Foundation for Chat SDK

## 0.6.0
* feat: Flag/Unflag post and comment 
* feat: init socket.io client 
* feat: Bloom filter for hashflag functionlity

## 0.5.0
* feat: CRUD Poll Post
* feat: Close Poll Post
* feat: Vote Poll Post
* fix: resolve the issue with Global Ban flag

## 0.4.0
* feat: Post Query Reaction
* feat: Comment/Nested Comment Query Reaction
* fix: Blank Custom Avatar Url
* fix: Blank Unfollow Response
* refactor: Optimize import & public api doc

## 0.3.1
* fix: GET post api issue
## 0.3.0
* feat: follow/unfollow functionlity
* feat: accept/denied pending follow request functionlity
* feat: Query user follower/following
* fix: login issue without display name
* fix: nested comment loading issue

## 0.2.0
* feat: Community Post Review feature
* feat: Query community by tag
* feat: add tags in community
* feat: add recommend and trending communities in public repo
* feat: Add Community Category in Create & Update Community
* fix: data type filtering in get post API
* fix: resolve edge case with page controller blank token
* fix: resolve issue with multiple post in community feed
* fix: updated post query for v4 api

## 0.1.3
* fix: null category ID in Community Category hive entiry
* fix: resolve edge case with page controller blank token

## 0.1.2
* chore: enable the lint core and analyze the code
## 0.1.1
* fix: community category causes data corruption
* fix: post metadata is unable to update


## 0.1.0

* feat: Add Metadata in post, comment and community
* feat: Streams for Post, Comment, Community and Community Member
* feat: Community CRUD and Query
* feat: Community Member CRUD and Query
* feat: Community Member Roles & Permissions
* feat: Community feed query
* feat: Add/Remove Post and Comment reactions
* fix: resolve memory leak issue in post and comment object


## 0.0.2

* feat: Comment CRUD and Query 
* fix: get_it instance issue


## 0.0.1

* docs: updated the README file
* docs: updated the LICENSE file

## 0.0.1-gazelle.3

* feat: added example for Amity Core client setup and login
* fix: updated plugin to null safety
* fix: update the code according to flutter analyze

## 0.0.1-gazelle.2

* docs: updated the README file
## 0.0.1-gazelle.1

