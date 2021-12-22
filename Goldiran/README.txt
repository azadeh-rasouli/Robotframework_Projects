I have written some Robotframework codes to test Goldiranplus.ir web page
To be able to run this code you need to have a user login for the website and create an argument file containing those username and password to login or else the test will fail

it should have the following format and should be saved as a text file (like Variables.txt):

-v  username:xxxxxxx
-v  password:xxxxxxx

Then for running the tests in pycharm you should include the file in the commnd (when you are in "Testcases" root) :

robot  -A  Variables.txt  Goldiranplus.robot
