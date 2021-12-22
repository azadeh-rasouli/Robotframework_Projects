## TO RUN the FILE :

#robot -d results -A  Variables.txt  Goldiranplus.robot
#variable argument file include username and password for login

*** Settings ***
Library            SeleniumLibrary
Library            Collections
Library            String
Resource           ../Resources/Common.robot


*** Variables ***
${Product_name}
${card_value}

*** Keywords ***

#-----------------------------------Check Homepage---------------------------------

Available parts

    Page Should Contain       پرفروش‌ترین‌ها
    Page Should Contain       جدیدترین‌ها
    Page Should Contain        پربازدیدترین‌ها


Check Products List
    Click Element       //div[contains(@class,"col-md-3")]/button
#check all TV products and menu
    Mouse Over   //a[@href= "/category/TVA"]
    Element Should Be Visible   //a[@href= "/category/TV"]
    Element Should Be Visible   //a[@href= "/category/android_box"]
    Element Should Be Visible   //a[@href= "/category/air_mouse"]
    Element Should Be Visible   //a[@href= "/category/TVT"]
#check home furniture and menu
    Mouse Over   //a[@href= "/category/HA"]
    #Wait Until Element Is Visible   //a[@href= "/category/ref"]
    Mouse Over   //a[@href= "/category/Ref"]
    Element Should Be Visible   //a[@href= "/category/WM"]
    Element Should Be Visible   //a[@href= "/category/HTS"]
    Element Should Be Visible   //a[@href= "/category/DW"]
    Element Should Be Visible   //a[@href= "/category/MWO"]
    Element Should Be Visible   //a[@href= "/category/GC"]
    Element Should Be Visible   //a[@href= "/category/Styler"]
    Element Should Be Visible   //a[@href= "/category/VC"]
    Mouse Over   //a[@href= "/category/it"]
    Mouse Over   //a[@href= "/category/AC"]
    Mouse Over   //a[@href= "/category/HE"]
    Mouse Over   //a[@href= "/category/mobile"]
    Mouse Over   //a[@href= "/category/SA"]

#---------------------------------Check Purchase------------------------------------------------------------------
Purchase An Available Mobile Scenario

    Click Element       //div[contains(@class,"col-md-3")]/button
    Wait until Element Is Visible    //a[@href= "/category/mobile"]
    Mouse Over   //a[@href= "/category/mobile"]
    Wait Until Element Is Visible   //a[@href= "/category/mobile1"]
    Click Element   //a[@href= "/category/mobile1"]
    Wait Until Element Is Visible       //div[contains(@class,"products-list")]/app-product-item[1]
    Click Element   //div[contains(@class,"products-list")]/app-product-item[1]

   #If the item is available "add to cart" will be shown
    ${cond}=       Run Keyword And Return Status    Wait Until Element Is Visible    //button[@class = "btn add-to-cart"]
    #Add the item to the cart and check that number "1" is shown on the basket
    Run Keyword If    ${cond}     Check Add to the cart



Purchase A Product Which is not Available
    Click Element       //div[contains(@class,"col-md-3")]/button
    Wait until Element Is Visible    //a[@href= "/category/mobile"]
    Mouse Over   //a[@href= "/category/mobile"]
    Click Element   //a[@href= "/category/mobile1"]
    Wait Until Element Is Visible       //div[contains(@class,"products-list")]/app-product-item[8]
    Click Element   //div[contains(@class,"products-list")]/app-product-item[8]
    Check Add to the cart



Purchase a Washing Machine
#select a washing machine
    sleep    10s
    Wait Until Element Is Visible   //div[contains(@class,"col-md-3")]/button
    Click Element       //div[contains(@class,"col-md-3")]/button
    Wait Until element Is visible   //a[@href= "/category/HA"]
    Mouse Over   //a[@href= "/category/HA"]
    Wait Until Element Is Visible  //a[@href= "/category/WM"]
    Mouse Over   //a[@href= "/category/WM"]
    Click Element     //a[@href= "/category/WM"]

#select search options to show only the available items

   Wait Until Element Is Visible    //*[@id="searchable-attributes"]
   Sleep     5s
  # Element Text Should be     //*[@id="searchable-attributes"]/app-product-search-accordion[2]/div[1]   وضعیت موجودی
   Execute javascript   document.getElementsByClassName('accordion-title')[2].click();
   Execute javascript   document.getElementsByClassName('checkbox-label')[0].click();
   # or
   # document.querySelector('checkbox-label').click()
   #Select Checkbox      //*[@id="searchable-attributes"]/app-product-search-accordion[2]/div[2]/label/span

# select the brand

  # Element Text Should be    //*[@id="searchable-attributes"]/app-product-search-accordion[4]/div[1]   برند
  # Execute javascript   document.getElementsByClassName('accordion-title')[3].click();
    Execute javascript   document.getElementById('brand1').click();

#Select the color

   #Element Text Should be   //*[@id="searchable-attributes"]/app-product-search-accordion[4]/div[2]/div[2]/label  رنگ
    Execute javascript   document.getElementsByClassName('accordion-title')[4].click();
    Execute javascript   document.getElementById('color1').click();

    Execute javascript   document.getElementsByClassName('accordion-title')[5].click();
    Execute javascript   document.getElementById('door7').click();

    Execute javascript   document.getElementsByClassName('accordion-title')[6].click();
    Execute javascript   document.getElementById('capacity5').click();

  #Check to see if there is any product available with selected settings

    ${availability_status}=       Run Keyword And Return Status      Page Should Not Contain     //*[@class="alert alert-warning ng-star-inserted"]
    Log to Console      ${availability_status}
    Run Keyword If      ${availability_status}!= True
                       ...   Click Element   //*[@id="content-container"]/ng-component/div/div[2]/div[2]/div/app-product-item[1]/div/div[1]/a
  #if there is no product we will remove the door type from the selected filters part
               ...   ELSE   Run Keywords

                     #  ...  Execute javascript   document.getElementsByClassName('accordion-title')[0].click();    AND
                        ...  Click Element   //*[@class ="ng-star-inserted"]//*[contains( text(),"مشکی بزرگ بدون فریم ")]    AND
                        ...  Wait Until Element Is Visible    //*[@id="content-container"]/ng-component/div/div[2]/div[2]/div/app-product-item[1]/div/div[1]/a    AND
                        ...  Click Element      //*[@id="content-container"]/ng-component/div/div[2]/div[2]/div/app-product-item[1]/div/div[1]/a    AND
                        ...  Wait Until Element Is Visible   //button[@class = "btn add-to-cart"]
                        #...  Click Element     //button[@class = "btn add-to-cart"]

# Check to see if the item is added to the basket
    Check Add to the cart
    Empty the cart


Adding to the number of items and removing it
    Click Element  //*[@id="header-actions"]/a[1]/span
    Wait Until Element Is Visible   //*[contains(@class,"form-control qty fa-num")]
    Click Element  //*[contains(@class,"form-control qty fa-num")]
    Wait Until Element Is Visible    //*[@id="cart-items"]/div[1]/div[1]/div/div[2]/select/option[3]
    Click Element  //*[@id="cart-items"]/div[1]/div[1]/div/div[2]/select/option[3]
    Click Element  //div[contains(@class,"remove-item")]
    Sleep   5
    Page Should Contain     سبد خرید شما خالی است !


*** Test Cases ***

Search and Open
    Google Search Goldiranplus
Check Available Parts in Home Page
    Available parts
Check if the partitions of products is correct
    Check Products List
Check Searching a Product
    Search a Product
Select a Product Which is not Available
    Purchase A Product Which is not Available
Add a mobile to the card
    Purchase An Available Mobile Scenario
Login To change the Items
    Login to Buy
    Adding to the number of items and removing it
Select a Washing Machine with searchable settings
    Purchase a Washing Machine
#End of the test
    #End Web Test
