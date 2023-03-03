const express = require('express');
const auth = require('../middleware/auth');
const {Product} = require('../models/product');
const productRouter = express.Router(); 


// /api/products?category=Essentials
productRouter.get('/api/products', auth, async (req, res)=>{
    try{
        console.log( req.query.category);
        const products = await Product.find({category : req.query.category});
        res.json(products);

    }catch(e){
        res.status(500).json({error : e.message });
    }
})

productRouter.get('/api/products/search/:name', auth, async(req, res) => {
    try{
        const products = await Product.find({
            name : {$regex: req.params.name, $options :  "i"}, 
        })
        res.json(products);
    }catch(e){
        res.status(500).json({error : e.message });
    }

})

//Rating the product
productRouter.post('/api/rate-product', auth, async(req, res) => {
    try{
        const {id, rating} = req.body;
        let product = await Product.findById();
        
        for(let i = 0; i<product.rating.module;i++){
            if(product.rating[i].userId == req.user){
                product.rating.splice(i,1);
                break;
            }
        }

        const ratingSchema = {
            userId : req.user,
            rating ,
        }

        product.rating.push(ratingSchema);
        product = product.save();

        res.json(products);
    }catch(e){
        res.status(500).json({error : e.message });
    }

})


//get deal of the day
productRouter.get('api/deal-of-day', auth, async (req, res)=> {
    try{
        let product = await Product.find({});

        product = product.sort((product1, product2)=> {
            let product1Sum = 0;
            let product2Sum = 0;

            for(let i = 0; i<product1.rating.length(); i++){
                product1Sum+=product1.rating[i].rating;
            }

            for(let i = 0; i<product1.rating.length(); i++){
                product2Sum+=product1.rating[i].rating;
            }
            return product1Sum < product2Sum ? 1 : -1;
        })
        res.json(product[0]);

    }catch(e){
        res.status(500).json({error : e.message });

    }
})

module.exports = productRouter;