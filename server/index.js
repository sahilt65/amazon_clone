// console.log("Hello World ")

// //importing express from packages
// const express = require('express');
// const mongoose = require('mongoose');
// const auth = require('./middleware/auth');
// const adminRouter = require('./route/admin');
// const userRouter = require('./route/user');

// //importing from other files
// const authRouter = require('./route/auth');
// const productRouter = require('./route/product');

// //INIT 
// const  PORT = 3000;
// const app = express();

// const DB = "mongodb+srv://sahil:sahil@userproduct.taan1vw.mongodb.net/?retryWrites=true&w=majority"


// //Middleware
// //Client(flutter) -> middleware -> Server(Node) -> Client(flutter)
// app.use(express.json()); 
// app.use(authRouter);
// app.use(auth);
// app.use(adminRouter);
// app.use(productRouter);
// app.use(userRouter);


// //connction
// mongoose.connect(DB).then(() => {
//     console.log("connection successfull");
// }).catch((e)=>{
//     console.log(e);
// });



// //CRUD -> Create Read Update and Delete
// //creating api
// //http://<yourapiadrress>/hello-world

// app.listen(PORT, "0.0.0.0", function(){
//     console.log(`connected at port ${PORT}` );
// })

// app.post('/sahil', (req,res) => {
//     console.log("sahil");
// })

// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./route/admin");

// IMPORTS FROM OTHER FILES
const authRouter = require("./route/auth");
const productRouter = require("./route/product");
const userRouter = require("./route/user");

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb+srv://sahil:sahil@userproduct.taan1vw.mongodb.net/?retryWrites=true&w=majority";

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
