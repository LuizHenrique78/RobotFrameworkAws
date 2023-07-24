***Settings***

Resource         resources/base.robot

***Test Cases***


Criação de bucket 
    [Tags]    createBucket    Bucket    positive
    [Documentation]        Criação e delete de bucket AWS S3 PosivtivO
    
    ${bucket_name}    Generate randon string  

    ${response}        Create Bucket        ${bucket_name} 
    Assertions Create bucket Suscess        ${response} 
    
    ${response}        Delete Buckets        ${bucket_name}

Criação de bucket com nome ja existente    
    [Tags]    createBucket    Bucket    negative
    [Documentation]        Criação de bucket AWS S3 bucket ja existente

    ${response}        List Buckets

    ${response}        Run Keyword And Expect Error     ${BucketAlreadyOwnedByYou}      Create Bucket        ${response[0]["Name"]} 
