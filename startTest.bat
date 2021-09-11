Rem Set the location of folder where .jmx present 
SET HOME=C:\GitHub\JmeterAssignment

Rem set the Jmeter installation folder till bin folder. 
SET jmeterHome=C:\Software\apache-jmeter-5.4.1\bin\

Rem location of script
SET script=%HOME%\GmailAPI.jmx

Rem Name of the flow- No need to change
SET FLOW=Gmail

Rem Set max number of threads , 
SET MaxUsers=5

Rem keep it same as number of threads, this will ensure max users are ramping in mentioned time – this value is in sec
SET RampUp=5

Rem Set max number of threads for negative scenario , make sure you have at-least these many number of rows in LoginPhone.csv
SET NMaxUsers=5

Rem keep it same as number of threads for negative scenario, this will ensure max users are ramping in mentioned time – this value is in sec
SET NRampUp=5

rem These will maintain the load on the server. It is Desired Hits/sec. However to achieve this, you should have enough max threads (MaxUsers) present in Jmeter. 
SET stratRPS=5

Rem //Keep it same as startRPS to have steady state value. 
SET endRPS=5

Rem Set the desired execution duration here – this is in sec. 
SET duration=300

Rem set this token expiry time in msec. Default max token life is 3599 sec
SET tokenexpirytime=120000

rem this is server name, if application env changes then just change this value no need to modify the script. 
SET BASE_URL_1=gmail.googleapis.com

rem Set the absolute path of the LoginPhone.csv file. 
SET TestDataFile1=userId.csv


rem below code is for genrating the unique testing timestam for creating unique name of each test result. 
FOR /F "TOKENS=1 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET dd=%%A
FOR /F "TOKENS=1,2 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET mm=%%B
FOR /F "TOKENS=1,2,3 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET yyyy=%%C
SET date=%dd%%mm%%yyyy%

FOR /F "TOKENS=1 eol=/ DELIMS=: " %%A IN ('time/t') DO SET hh=%%A
FOR /F "TOKENS=1,2 eol=/ DELIMS=: " %%A IN ('time/t') DO SET mins=%%B
FOR /F "TOKENS=1,2,3 eol=/ DELIMS=: " %%A IN ('time/t') DO SET sec=%%C
Set timestamp=%hh%%mins%%sec%

if not exist "%HOME%\Execution-Reporting" mkdir %HOME%\Execution-Reporting
SET ResultFolder=%HOME%\Execution-Reporting\%FLOW%-%MaxUsers%User-%date%-%timestamp%


rem   command will start the non GUI load test for the desired number of users. you can see the results in the Execution-Reporting once test is complete. this will not open the jmeterin GUI. All the HTML results can be seen after the test completion. Anlayis can only be done after the completion of the test. 
%jmeterHome%jmeter -n -t %script% -JMaxUsers=%MaxUsers% -JRampUp=%RampUp% -JNMaxUsers=%MaxUsers% -JNRampUp=%RampUp% -Jduration=%duration% -JBASE_URL_1=%BASE_URL_1% -JTestDataFile1=%TestDataFile1%  -l %ResultFolder%\%FLOW%-%MaxUsers%-results.jtl -j %ResultFolder%\jmeter.log -e -o %ResultFolder%\HtmlReport
