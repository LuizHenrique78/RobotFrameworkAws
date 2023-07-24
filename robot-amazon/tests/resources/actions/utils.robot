
***Keywords***
Generate randon string 
    ${List}        Create List     a    b    c    d    e    f    g    h    i    j    k    l    m    n    o    p    q    r    s    t    u    v    w    x    y    z
    ${randon_string}    Evaluate    ''.join(random.choice(${List}) for _ in range(10))         random      
    Log To Console    ${randon_string}

    [Return]        ${randon_string}


Should be Integer 
    [Arguments]        ${my_integer}
    
    ${my_integer}    Set Variable         ${my_integer}  
    ${my_string}     Convert To String    ${my_integer}
    Should Not Be Empty    ${my_string}
