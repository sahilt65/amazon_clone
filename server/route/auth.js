const express = require("express");
const bcryptjs = require('bcryptjs')
const User = require("../models/user")
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require("../middleware/auth");
// app.use(auth);


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

//validate User

authRouter.post('/tokenIsValid', async (req, res) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.json(false); 
        }

        const verified = jwt.verify(token, 'passwordKey');

        if(!verified){
            return res.json(false);
        }

        const user = await User.findById(verified.id);

        if(!user){
            return res.json(false); 
        }
        return res.json(true); 

    }catch(e){
        res.status(500).json({error:e.message});
    }
})


//Get User data
authRouter.get("/", auth, async (req, res)=>{
    const user = await User.findById(req.user);

    res.json({...user._doc, token : req.token});
})


module.exports = authRouter;