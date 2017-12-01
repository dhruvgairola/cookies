var app = require('express')();
var http = require('http').Server(app);
var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const vision = require('@google-cloud/vision');

// Creates a client
const client = new vision.ImageAnnotatorClient();

app.post('/getImageMetadata', function(req, res){
    var base64Data = req.body.image;
    
    require("fs").writeFile("resources/out.jpg", base64Data, 'base64', function(err) {
      console.log(err);
    });

  client
  .documentTextDetection('./resources/out.jpg')
  .then(results => {
    const labels = results[0].textAnnotations;

    var retStr = "";
    labels.forEach(label => {retStr += label.description + " "});

    res.send(retStr); 
  })
  .catch(err => {
    console.error('ERROR:', err);
  });


});

http.listen(3001, function(){
  console.log('listening on *:3001');
});

// Imports the Google Cloud client library
