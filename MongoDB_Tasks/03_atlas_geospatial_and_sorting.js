// ======================================================================
// Topic: Geospatial Queries and Advanced Aggregations
// Databases: sample_mflix (theaters), sample_airbnb (listingsAndReviews)
// ======================================================================

// 1. Find all theaters in California (CA) within a specific geographic polygon and count them.
// Collection: sample_mflix.theaters
db.theaters.aggregate([
  {
    $match: {
      "location.address.state": "CA",
      "location.geo": {
        $geoWithin: {
          $geometry: {
            type: "Polygon",
            coordinates: [[
              [-117.5744390487671, 33.4357390068682],
              [-116.85809612274171, 33.36153851470541],
              [-116.77368164062501, 33.72583877477767],
              [-116.71480178833009, 33.99493181041714],
              [-116.9643545150757, 34.245687792601274],
              [-117.12069511413576, 34.59135376477144],
              [-117.64434814453126, 34.724225102733485],
              [-117.96372413635255, 34.80058950800775],
              [-118.51389884948732, 34.746020486446874],
              [-118.90468597412111, 34.59018790428903],
              [-120.10987758636476, 34.48943826358944],
              [-117.5744390487671, 33.4357390068682]
            ]]
          }
        }
      }
    }
  },
  { $count: "total_theaters" }
]);
// Expected Result: { total_theaters: 73 }

// ======================================================================

// 2. Find the property with the highest number of bedrooms and output its name.
// Collection: sample_airbnb.listingsAndReviews
db.listingsAndReviews.aggregate([
  { $sort: { bedrooms: -1 } },
  { $limit: 1 },
  { $project: { _id: 0, name: 1, bedrooms: 1 } }
]);
// Expected Result: { name: "Venue Hotel Old City", bedrooms: 20 }

// ======================================================================

// 3. Find the property with the highest rating that has at least 50 reviews.
// Collection: sample_airbnb.listingsAndReviews
db.listingsAndReviews.aggregate([
  { $match: { number_of_reviews: { $gte: 50 } } },
  { $sort: { "review_scores.review_scores_rating": -1 } },
  { $limit: 1 },
  { $project: { _id: 0, name: 1 } }
]);
// Expected Result: { name: "Sydney Hyde Park City Apartment (checkin from 6am)" }
