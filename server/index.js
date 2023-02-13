console.log("Hello World ")

//importing express from packages
const express = require('express');
const mongoose = require('mongoose');
const auth = require('./middleware/auth');

//importing from other files
const authRouter = require('./route/auth')

//INIT 
const  PORT = 3000;
const app = express();
const DB = "mongodb+srv://sahil:sahil123@cluster0.p8alflo.mongodb.net/?retryWrites=true&w=majority";


//Middleware
//Client(flutter) -> middleware -> Server(Node) -> Client(flutter)
app.use(express.json()); 
app.use(authRouter);
app.use(auth);


//connction
mongoose.connect(DB).then(() => {
    console.log("connection successfull");
}).catch((e)=>{
    console.log(e);
});



//CRUD -> Create Read Update and Delete
//creating api
//http://<yourapiadrress>/hello-world

app.listen(PORT, "0.0.0.0", function(){
    console.log(`connected at port ${PORT}` );
})