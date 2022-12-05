const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product");

// Add Product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;

    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });

    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ msg: e.message });
  }
});

// Get all products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});

    res.json(products);
  } catch (e) {
    res.status(500).json({ msg: e.message });
  }
});

// DELETE PRODUCT

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    const deletingProduct = await Product.findById(id);
    let product = await Product.findByIdAndDelete(id);
    // product = await product.save();
    // print(product);
    res.json(deletingProduct);
  } catch (e) {
    res.status(500).json({ msg: e.message });
  }
});

module.exports = adminRouter;
