*** Settings ***

Resource     ../utils.robot
*** Keywords ***



Assertions Create bucket Suscess
    [Arguments]        ${response}

    ${metadata}        Set Variable        ${response["ResponseMetadata"]}
    ${HTTPHeaders}     Set Variable        ${response["ResponseMetadata"]["HTTPHeaders"]}
    ${Location}        Set Variable        ${response["Location"]}


    Should Not Be Empty    ${metadata["RequestId"]}
    Should Not Be Empty    ${metadata["HostId"]}
    Should be Equal        ${metadata["HTTPStatusCode"]}        ${200}
    Should Not Be Empty    ${HTTPHeaders["x-amz-id-2"]}
    Should Not Be Empty    ${HTTPHeaders["x-amz-request-id"]}
    Should Not Be Empty    ${HTTPHeaders["date"]}
    Should Not Be Empty    ${HTTPHeaders["location"]}
    Should Not Be Empty    ${HTTPHeaders["server"]}
    Should Not Be Empty    ${HTTPHeaders["content-length"]}
    Should be Integer         ${metadata["RetryAttempts"]}
    Should Not Be Empty    ${Location}


    