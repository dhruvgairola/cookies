var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res){
	res.send("Hello World!")
});

app.get('/newItem', function(req,res){
    var id = req.query.newItem;
    var str = unescape(id);
    var userId = req.query.userId
    var obj = {item: str, userId: userId}

	console.log(obj.item)
	io.emit('newItems', obj)
    res.send("done")
});

app.get('/updateList', function(req,res){
	io.emit('updateList', "test")
    res.send("done")
});

app.get('/newOrder', function(req,res){
    var id = req.query.newOrder;
    var str = unescape(id);
    var userId = req.query.userId
    var obj = {item: str, userId: userId}

	console.log(str)
	io.emit('newOrder', obj)
    res.send("done")
});


http.listen(3000, function(){
  console.log('listening on *:3000');
});

io.on('connection', function(socket){

    console.log('a user connected');
  socket.on('disconnect', function(){
    console.log('user disconnected');
  });
});