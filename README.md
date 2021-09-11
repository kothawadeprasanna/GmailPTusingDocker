
#  Gmail API testing using Jmeter

Hi :wave:- Here, we will create Jmeter script for gmail API and create a docker image for the same. We will also use that to execute and generate report.



## API Reference

[API details](https://developers.google.com/gmail/api/reference/rest/v1/users.drafts/list)

###  users.drafts.list 
Lists the drafts in the user's mailbox.
```http
  GET https://gmail.googleapis.com/gmail/v1/users/{userId}/drafts
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `userId` | `string` | **Required**. Gmail address|


| Header Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Authorization` | `string` |Bearer Access token generated by OAuth|

This API requires Requires one of the following OAuth scopes:
* https://mail.google.com/
* https://www.googleapis.com/auth/gmail.modify
* https://www.googleapis.com/auth/gmail.compose
* https://www.googleapis.com/auth/gmail.readonly

### OAuth2 Token generation
To access the above API user need to pass the access token. Which is valid for 3599 sec. So, user will need to generate that every hour. 

Follow this page to setup and create access token:
* [Using OAuth 2.0 to Access Google APIs](https://developers.google.com/identity/protocols/oauth2)

Below is short summary to setup OAuth2: 
  1. Obtain OAuth 2. 0 credentials from the Google API Console. ...
  2. Obtain an access token from the Google Authorization Server. ...
  3. Examine scopes of access granted by the user. ...
  4. Send the access token to an API. ...
  5. Generate Refresh access token.
  
  As refresh token can be used for longer duration upto 6 months. So, we will use that to generate the Access token. 
  
## Software Installations

To run this user needs below softwares to be installed
* [JAVA](https://positive-stud.medium.com/step-by-step-guide-to-install-java-on-windows-pc-c85e7778c14c) 
* [JMETER](https://www.guru99.com/guide-to-install-jmeter.html)

Or 

* Use docker image containing required script and testdata.  

 [PULL IMAGE](https://hub.docker.com/r/pkothawade/jmeterforgmail)

```bash
  docker pull pkothawade/jmeterforgmail
```

## Script description

<details>
  <summary>Script description</summary>
  
          <p>Script contains two thread groups - 
          * "Thread group: Positive" for positive scenario where http: 200 response code is expected 
          * "Thread group: Negative" for negative scenario where older token is passed to get the http: 401 response code. 
          </p>
          <p>List of variables- 
           

          </p>
        
</details>
    
<details>    
  <summary>Script Logic</summary>
  
          <p>In positive test scenario we require Access token to test the gmail -/users/draft API.
          This Access token generation API requires Refresh token and client_id,client_secret. In reposne to this API we get access token, which we use in next request.  
          The access token is valid for only 1 hr and need to regenerate upon expiry. 
          Entire script is very much configurable based on the defined properties and variables. 
          </p>
    
</details>

## Execution
### Running Tests in machine using raw .jmx file

To run tests, run the following command
Below properties can be passed externally:
1. MaxUsers: Postive scenario max thread number
2. RampUp: Postive scenario Ramp up time
3. duration: Overall test duration
4. NMaxUsers: Negative scenario max thread number
5. NRampUp: Negative scenario Ramp up time
6. TestDataFile1 : CSV file containing - userId,client_id,client_secret,refresh_token 

Execute below command to run the test. Modify commnad as per your requirement.
```bash
  jmeter -n -t GmailAPI.jmx -JMaxUsers=5 -JRampUp=5 -JNMaxUsers=5 -JNRampUp=5
   -Jduration=30 -JTestDataFile1='userId.csv'  -l Gmail-5-results.jtl -j jmeter.log -e -o HtmlReport
```
One can modify startTest.bat present in git to start test in single click. (This requires all the parameters set correctly in the .bat file)

### Running Tests in Docker

To run tests, run the following command

```bash
docker run pkothawade/jmeterforgmail -n -t GmailAPI.jmx -JMaxUsers=5 -JRampUp=5 -JNMaxUsers=5 -JNRampUp=5 -Jduration=30
 -JTestDataFile1='userId.csv'  -l Gmail-5-results.jtl -j jmeter.log -e -o HtmlReport
```

## Analyse results:

*EXECUTE TEST:*
```bash
  docker run pkothawade/jmeterforgmail -n -t GmailAPI.jmx -JMaxUsers=5 -JRampUp=5 -JNMaxUsers=5 -JNRampUp=5 -Jduration=30
   -JTestDataFile1='userId.csv'  -l Gmail-5-results.jtl -j jmeter.log -e -o HtmlReport
```
*ANALYSE RESULT:*
```bash
  Get the docker container id :
  docker ps -a
```  
  get the container id as first coloum and replace that with da25032fa395 in below command
```bash
  docker cp da25032fa395:/opt/apache-jmeter-5.3/Gmail-5-results.jtl .
  OPEN DOWNLOADED .JTL FILE IN VIEWRESULTTREE/AGGREGATESUMAMRY OR YOUR FAVOURITE LISTENER.
  
  docker cp da25032fa395:/opt/apache-jmeter-5.3/HtmlReport .
  OPEN DOWNLOADED HTML REPORT IN ANY BROWSER. 
```
  
  
## Documentation

[API reference](https://developers.google.com/gmail/api/reference/rest/v1/users.drafts/list)

  
## Authors

- [@Prasanna Kothawade](https://github.com/kothawadeprasanna)


  
