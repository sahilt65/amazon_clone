const express = require("express");
const bcryptjs = require('bcryptjs')
const User = require("../models/user")
const authRouter = express.Router();
const jwt = require('jsonwebtoken');


authRouter.post("/api/signup", async function (req, res){
    
    try{
        //get data from client
        const { name, email, password } =  req.body;
        //post data in database
        const existingUser = await User.findOne({ email });

        if(existingUser){
            return res.status(400).json({msg : 'User with same email already exists!'}); 
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
authRouter.post('/api/signin', async (req, res)=>{

    try{
        const{email, password} = req.body;

        const user = await User.findOne({email});


        if(!user){
            return res.status(400).json({msg : 'User does not exist please create account to sign in'}); 
        }

        const isMatch = await bcryptjs.compare(password, user.password);

        if(!isMatch){
            return res.status(400).json({msg : 'Incorrect Password'}); 
        }

        const token = jwt.sign({id : user._id}, "passwordKey");
        res.json({token, ...user._doc })

    }catch(e){
        res.status(500).json({error : e.message});
        
    }

})


module.exports = authRouter;