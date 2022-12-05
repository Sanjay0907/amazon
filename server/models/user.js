const mongoose = require("mongoose");
const Product = require("./product");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    trim: true,
    type: String,
  },
  email: {
    required: true,
    trim: true,
    type: String,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Opps! invalid Email",
    },
  },
  password: {
    required: true,
    trim: true,
    type: String,
  },
  password: {
    required: true,
    type: String,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "User",
  },
  // CART
  cart: [
    {
      product: Product.productSchema,
      quantity: { type: Number, require: true },
    },
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
