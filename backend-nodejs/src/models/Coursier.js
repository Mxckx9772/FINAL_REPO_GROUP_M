
const { Timestamp } = require('mongodb');
const mongoose = require('mongoose');
const CoursierSchema = new mongoose.Schema(
	{
		coursierId: {
			type: mongoose.Schema.Types.ObjectId,
			required: true,
		},
		email: {
			type: String,
			default : null
		},
		password: {
			type: String,
			required: [true, 'Please provide a password'],
			minlength: 8,
			validate(value) {
				if (!value.match(/\d/) || !value.match(/[a-zA-Z]/)) {
					throw new Error('Password must contain at least one letter and one number');
				}
			},
		},
		username: {
			type: String,
			unique: true,
		},
		role: {
			type: String,
			default:'coursier'
		},
		familiyName: {
			type: String,
            required: true,
		},
        name: {
			type: String,
            required: true,
		},
		origin: {
			city: { type: String },
			streetName: { type: String },
			country: { type: String },
			countryCode: { type: String },
			postalCode: { type: String },
			region: { type: String },
			phone: { type: String },
			fullAdress: { type: String },
			street1: { type: String },
			street2: { type: String },
		},
        // any info that would be visible (or not) on the coursier profile

        profileInfo: { 
			birthDate: { type: Date },
			bio: { type: String },
			profilePicture: { 
                data: Buffer,
                contentType: String,
            },
			serviceRating: { type: Number }, 
		}, 
        isAvailable: {
            type: Boolean,
            default: false,
        }, 
		isVerified: {
			type:Boolean,
			enum: ['verified', 'processing', 'refused'],
			default: false,
		}
	},
	{
		timestamps: true,
		toJSON: { virtuals: true },
	}
);

// return the full name of coursier

CoursierSchema.virtual('fullName').get(function() {
    return `${this.name} ${this.familyName}`;
  });



module.exports = mongoose.model('Coursier', CoursierSchema);