*** Settings ***
Library            SeleniumLibrary
*** Variables ***
${username}
${password}
${before_items}
${after_items}

*** Keywords ***
Begin Web Test
    Open Browser    about:blank  Chrome
    #Maximize Browser Window


End Web Test
    Close All Browsers


Google Search
    Open Browser     https://www.google.com   Google Chrome
    Input Text    //input[@class ="gLFyf gsfi"]    Goldiran
    Wait Until Element Is Visible   //input[@class = "gNO89b"]
    Click Element  //input[@class = "gNO89b"]

    #returns the first matching locator
    #Set ${web-element} = Get Web Element  //*[@id="rso"]/div[1]/div/div/div/div/div/div/div[1]/a/h3
    # Click Element  ${web-element}

 #we are looking for goldiran.ir, since it may not be the first search result, it's better to use "contains"
    Click Element   //a [contains (@href , "goldiran.ir")]


Google Search Goldiranplus
    Open Browser     https://www.google.com   Google Chrome
    Input Text    //input[@class ="gLFyf gsfi"]    Goldiranplus
    Wait Until Page Contains Element   //input[contains(@value,"Google Search")]
    #**** first the locator didn't work as in the file products_Goldiran, so I added parent tags at the end of the locator so it works
    Click Element    //div[contains(@class,"FPdoLc")]/center/input
    Click Element   //a [contains (@href , "goldiranplus.ir")]


Check Add to the cart
    #if nothing is added to the card yet the element won't be visible
   ${cond1}=       Run Keyword And Return Status    Wait Until Element Is Visible       //*[contains(@class, "cart-quantity")]

   IF     ${cond1}
   ${before_items}=    Get Text    //*[contains(@class, "cart-quantity")]
   ELSE
   ${before_items}=  Set Variable   0
   END

   Log to Console       ${before_items}

   #When the item is available and add to the cart button is available
   ${cond}=       Run Keyword And Return Status    Wait Until Element Is Visible    //button[@class = "btn add-to-cart"]
   Run keyword If    ${cond}    Run Keywords
                                  ...   Click Element  //button[@class = "btn add-to-cart"]    AND
                                  ...   Wait Until Element Is Visible    //*[@id="header-actions"]/a[1]/span

   #if the new item is added to the cart                              .
   IF   ${cond}
   #number of items in the bcart should be increased by one after clicking the button
   ${after_items}=     Get Text    //*[@id="header-actions"]/a[1]/span
   Log to Console       ${after_items}
   ${before_items}=   Convert To Number   ${before_items}
   ${before_items}=   Set Variable   ${before_items+1}
   END

   # To check and see if after clicking "add to the cart" button the number of items in the cart is increased by one
   Run keyword If    ${cond}    Run Keywords
                                  ...   Should Be Equal As Numbers  ${before_items}  ${after_items}     AND
                                  ...   Click Element      //*[@id="header-actions"]/a[1]/span
                ...    ELSE      Run Keywords
                                  ...    Click Element     //*[@id="header-top"]/div/div/div[1]/a   AND
                                  ...    sleep       2s     AND
                                  ...    Wait Until Page Contains    ناموجود     5


Empty the cart

    Click Element  //*[@id="header-actions"]/a[1]/span
    Wait Until Element Is Visible     //*[@id="cart-items"]/div[2]/div/button
    Click Element     //*[@id="cart-items"]/div[2]/div/button
    Sleep      8
    Page Should Contain      سبد خرید شما خالی است !


Search a Product
    Input Text   //*[@id="search-box"]    کولر
    #i tried a lot of elements but they were wrong. if move the mouse arround the magnifying glass and select inspect when
    #mouse is like the hand then will find the correct locator
    Click Element   //*[contains (@class, "search-icon")]


Login to Buy
    Wait Until Element Is Visible    //input[@id= "username"]
    Input Text   //input[@id= "username"]    ${username}
    Input Password   //input[@id= "password"]  ${password}
    Click Element    //button[contains(@class, "btn btn-primary btn-lg")]
    Wait until Element Is Visible    //*[@id="userDropdownMenuButton"]
