const { Timestamp } = require('mongodb');
const mongoose = require('mongoose');

const deliverySchema = new mongoose.Schema({
    coursierId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Coursier',
      required: true,
    },
    orderId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Order',
      required: true,
    },
    deliveryDate: {
      type: Date,
      required: true,
    },
    status: {
      type: String,
      enum: ['confirmed', 'cancelled', 'ongoing','beingCancelled'],
      default: 'ongoing',
    },
    earning:{
      type: Number,
    },
    distance:{
      type:Number,
    },
    isCollected:{
      type:Boolean,
      default:false,
    }
    
  }, { timestamps: true });


module.exports = mongoose.model('Delivery', deliverySchema);