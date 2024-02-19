from compact_dict import Dict
from testing import assert_equal

fn s3_action_names() raises -> DynamicVector[String]:
    return String('AbortMultipartUpload CompleteMultipartUpload CopyObject CreateBucket CreateMultipartUpload DeleteBucket DeleteBucketAnalyticsConfiguration DeleteBucketCors DeleteBucketEncryption DeleteBucketIntelligentTieringConfiguration DeleteBucketInventoryConfiguration DeleteBucketLifecycle DeleteBucketMetricsConfiguration DeleteBucketOwnershipControls DeleteBucketPolicy DeleteBucketReplication DeleteBucketTagging DeleteBucketWebsite DeleteObject DeleteObjects DeleteObjectTagging DeletePublicAccessBlock GetBucketAccelerateConfiguration GetBucketAcl GetBucketAnalyticsConfiguration GetBucketCors GetBucketEncryption GetBucketIntelligentTieringConfiguration GetBucketInventoryConfiguration GetBucketLifecycle GetBucketLifecycleConfiguration GetBucketLocation GetBucketLogging GetBucketMetricsConfiguration GetBucketNotification GetBucketNotificationConfiguration GetBucketOwnershipControls GetBucketPolicy GetBucketPolicyStatus GetBucketReplication GetBucketRequestPayment GetBucketTagging GetBucketVersioning GetBucketWebsite GetObject GetObjectAcl GetObjectAttributes GetObjectLegalHold GetObjectLockConfiguration GetObjectRetention GetObjectTagging GetObjectTorrent GetPublicAccessBlock HeadBucket HeadObject ListBucketAnalyticsConfigurations ListBucketIntelligentTieringConfigurations ListBucketInventoryConfigurations ListBucketMetricsConfigurations ListBuckets ListMultipartUploads ListObjects ListObjectsV2 ListObjectVersions ListParts PutBucketAccelerateConfiguration PutBucketAcl PutBucketAnalyticsConfiguration PutBucketCors PutBucketEncryption PutBucketIntelligentTieringConfiguration PutBucketInventoryConfiguration PutBucketLifecycle PutBucketLifecycleConfiguration PutBucketLogging PutBucketMetricsConfiguration PutBucketNotification PutBucketNotificationConfiguration PutBucketOwnershipControls PutBucketPolicy PutBucketReplication PutBucketRequestPayment PutBucketTagging PutBucketVersioning PutBucketWebsite PutObject PutObjectAcl PutObjectLegalHold PutObjectLockConfiguration PutObjectRetention PutObjectTagging PutPublicAccessBlock RestoreObject SelectObjectContent UploadPart UploadPartCopy WriteGetObjectResponse", "CreateAccessPoint CreateAccessPointForObjectLambda CreateBucket CreateJob CreateMultiRegionAccessPoint DeleteAccessPoint DeleteAccessPointForObjectLambda DeleteAccessPointPolicy DeleteAccessPointPolicyForObjectLambda DeleteBucket DeleteBucketLifecycleConfiguration DeleteBucketPolicy DeleteBucketReplication DeleteBucketTagging DeleteJobTagging DeleteMultiRegionAccessPoint DeletePublicAccessBlock DeleteStorageLensConfiguration DeleteStorageLensConfigurationTagging DescribeJob DescribeMultiRegionAccessPointOperation GetAccessPoint GetAccessPointConfigurationForObjectLambda GetAccessPointForObjectLambda GetAccessPointPolicy GetAccessPointPolicyForObjectLambda GetAccessPointPolicyStatus GetAccessPointPolicyStatusForObjectLambda GetBucket GetBucketLifecycleConfiguration GetBucketPolicy GetBucketReplication GetBucketTagging GetBucketVersioning GetJobTagging GetMultiRegionAccessPoint GetMultiRegionAccessPointPolicy GetMultiRegionAccessPointPolicyStatus GetMultiRegionAccessPointRoutes GetPublicAccessBlock GetStorageLensConfiguration GetStorageLensConfigurationTagging ListAccessPoints ListAccessPointsForObjectLambda ListJobs ListMultiRegionAccessPoints ListRegionalBuckets ListStorageLensConfigurations PutAccessPointConfigurationForObjectLambda PutAccessPointPolicy PutAccessPointPolicyForObjectLambda PutBucketLifecycleConfiguration PutBucketPolicy PutBucketReplication PutBucketTagging PutBucketVersioning PutJobTagging PutMultiRegionAccessPointPolicy PutPublicAccessBlock PutStorageLensConfiguration PutStorageLensConfigurationTagging SubmitMultiRegionAccessPointRoutes UpdateJobPriority UpdateJobStatus').split(" ")

fn test_simple_manipulations() raises:
    var d = Dict[Int, KeyCountType=DType.uint8, KeyOffsetType=DType.uint16]()
    let corpus = s3_action_names()
    for i in range(len(corpus)):
        d.put(corpus[i], i)
    
    assert_equal(len(d), 143)
    assert_equal(d.get("CopyObject", -1), 2)
    
    d.delete("CopyObject")
    assert_equal(d.get("CopyObject", -1), -1)
    assert_equal(len(d), 142)
    
    d.put("CopyObjects", 256)
    assert_equal(d.get("CopyObjects", -1), 256)
    assert_equal(d.get("CopyObject", -1), -1)
    assert_equal(len(d), 143)

    d.put("CopyObject", 257)
    assert_equal(d.get("CopyObject", -1), 257)
    assert_equal(len(d), 144)

fn test_simple_manipulations_on_non_destructive() raises:
    var d = Dict[Int, KeyCountType=DType.uint8, KeyOffsetType=DType.uint16,  non_destructive=True]()
    let corpus = s3_action_names()
    for i in range(len(corpus)):
        d.put(corpus[i], i)
    
    assert_equal(len(d), 143)
    assert_equal(d.get("CopyObject", -1), 2)
    
    d.delete("CopyObject")
    assert_equal(d.get("CopyObject", -1), 2)
    assert_equal(len(d), 143)
    
    d.put("CopyObjects", 256)
    assert_equal(d.get("CopyObjects", -1), 256)
    assert_equal(d.get("CopyObject", -1), 2)
    assert_equal(len(d), 144)

    d.put("CopyObject", 257)
    assert_equal(d.get("CopyObject", -1), 257)
    assert_equal(len(d), 144)

fn main()raises:
    test_simple_manipulations()
    test_simple_manipulations_on_non_destructive()