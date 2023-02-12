const express = require("express");
const bcryptjs = require('bcryptjs')
const User = require("../models/user")
const authRouter = express.Router();


authRouter.post("/api/signup", async function (req, res){
    
    try{
        //get data from client
        const { name, email, password } =  req.body;
        //post data in database
        const existingUser = await User.findOne({ email });

        if(existingUser){
            return res.status(400).json({msg : 'User with sam email already exists!'}); 
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
    
        let user = new User({
            name,
            email,
            password : hashedPassword,
        })
        /*
        {
        'name' : name,
        'email' : email,
        'password' : password,
        }
        */
    
        user = await user.save();
        res.json(user);
    }catch(e){
        res.status(500).json({error : e.message});
    }
    
    //return that data to user
    // console.log(req.body);
})

 //Sign In Route
 

module.exports = authRouter;