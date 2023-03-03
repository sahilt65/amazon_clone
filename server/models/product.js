const mongoose = require("mongoose");
const authRouter = require("../route/auth");
const ratingSchema = require("./rating");
mongoose.set('strictQuery', false);
const productSchema = mongoose.Schema({
    name : {
        required : true,
        type : String,
        trim : true,
    },

    description : {
        required  : true,
        type: String, 
        trim: true,
    },

    images : [
        {   
            type : String,
            required : true,
        }
    ],

    quantity : {
        type : Number,
        required : true,
    },

    category:{
        type: String,
        required : true,

    },

    price : {
        type : Number,
        required : true,
    },

    rating : [ratingSchema],
    // userId : {
    // can be then used when multiple admins are there
    // }
})

const Product  = mongoose.model('Product', productSchema);
module.exports = {Product, productSchema}; 