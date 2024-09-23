*** Settings ***
Library           RequestsLibrary


*** Variables ***
${BASE_URL}    http://127.0.0.1:5000
${ERROR_400_MESSAGE}    Invalid input: both parameters must be numbers

*** Keywords ***
Call Addition API and Check Result
    [Arguments]    ${num1}    ${num2}    ${expected_result}
    ${response}=    GET    ${BASE_URL}/plus/${num1}/${num2}

    Status Should Be    200

    ${result}=    Convert To Number    ${response.json()["result"]}
    Should Be Equal As Numbers    ${result}    ${expected_result}

# Call Addition API and Check Error
#     [Arguments]    ${num1}    ${num2}    ${expected_status}
#     ${response}=    GET    ${BASE_URL}/plus/${num1}/${num2}    

#     # Check the status code directly from the response
#     Run Keyword If    '${response}' == 'None'    Fail    Expected error response but got a successful response.
    
#     Status Should Be    ${expected_status}

*** Test Cases ***

Test Addition of Positive Integer Numbers
    [Documentation]    test adds positive integer numbers.
    [Tags]    positive    integer
    Call Addition API and Check Result    5    7    12
    Call Addition API and Check Result    14   1    15

Test Addition of Negative Integer Numbers
    [Documentation]    test adds negative integer numbers.
    [Tags]    negative    integer
    Call Addition API and Check Result    -5    -7    -12
    Call Addition API and Check Result    -4    -1    -5

Test Addition with Zero
    [Documentation]    test adds number with zero.
    [Tags]    zero
    Call Addition API and Check Result    10    0    10
    Call Addition API and Check Result    -10    0    -10
    Call Addition API and Check Result    1.2    0    1.2
    Call Addition API and Check Result    -1.2    0    -1.2

Test Addition of Positive Decimal Number
    [Documentation]    test adds two positive decimal numbers.
    [Tags]    positive    decimal
    Call Addition API and Check Result    0.5    0.5    1.0
    Call Addition API and Check Result    3.0    1.5    4.5
    Call Addition API and Check Result    5.0    5.0    10

Test Addition with Negative Decimals
    [Tags]    negative    decimal
    Call Addition API and Check Result    -1.5    -2.5    -4.0
    Call Addition API and Check Result    -0.5    -0.5    -1.0
    Call Addition API and Check Result    -3.0    -1.5    -4.5

# Test Addition with Invalid Input
#     [Documentation]    test adds number with one string.
#     [Tags]    error
#     Call Addition API and Check Error   abc    4      400  
#     Call Addition API and Check Error   abc    4.5    400  
#     Call Addition API and Check Error   abc    -4     400  
#     Call Addition API and Check Error   abc    -4.5   400
#     Call Addition API and Check Error   abc    def    400   
