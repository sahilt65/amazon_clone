const express = require('express');
const productRouter = express.Router(); 
const auth = require('../middleware/auth');
const { Product } = require('../models/product');


// /api/products?category=Essentials
productRouter.get("/api/products/", auth, async (req, res) => {
    try {
      const products = await Product.find({ category: req.query.category });
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
});

// create a get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
      const products = await Product.find({
        name: { $regex: req.params.name, $options: "i" },
      });
  
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

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
productRouter.get('/api/deal-of-day', auth, async (req, res)=> {
    try{
        let products = await Product.find({});
        console.log("Sahil : "+products);
        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;
            console.log("hksdbfhj");
            console.log(a.rating.length);
            for (let i = 0; i < a.ratings.length; i++) {
                aSum += a.ratings[i].rating;
            }

            for (let i = 0; i < b.ratings.length; i++) {
                bSum += b.ratings[i].rating;
            }
            return aSum < bSum ? 1 : -1;
        });
        console.log("Sahil : "+products);

    res.json(products[0]);

    }catch(e){
        console.log(e.message);
        res.status(500).json({error : e.message });

    }
})

module.exports = productRouter;