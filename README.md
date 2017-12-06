# Pic and Pick (codenamed : Cookies)

## Description
* Use your iphone to scan grocery images and get item information. This is faster than barcode scanning. 
* Sync item information across all your family's phones in real-time. 60% of families shop cooperatively. 
* Code was written for an all-nighter Hackathon.

## Team Members
* Dhruv Gairola (api, ml)
* Nick Gorman (iphone, sockets)
* Anthony Chow (api, sockets, ml)
* Cibisounder Sadasivam (ml)

## Components
* Spring Boot API for business logic (cookies_api)
```
# Deployment :
./gradlew build
java -jar build/libs/cookies-1.0.jar
```
* iPhone App (cookies_iphone)
* NodeJS Sockets Server for real-time sync (cookies_node)
```
# Deployment :
npm install
node index.js
```
* NodeJS Server for obtaining labels from images (cookies_ml)
```
# Deployment :
# Add to .bash_profile
export GOOGLE_APPLICATION_CREDENTIALS=<path to your Google Vision api credentials (JSON)>

npm install --save @google-cloud/vision

npm install body-parser --save

npm install -g node-gyp

npm install gcloud

npm install express

npm install

node index.js
```

## Deployment
* We deployed the non-iphone related code on an EC2 Amazon Linux instance.
* We deployed a PostgresDB on the same machine.
* Change the hardcoded urls in cookies_api (CookiesController.java, application.properties) and cookies_iphone to point to your instance.
* Follow the instructions under the "Components" section for the individual components.
