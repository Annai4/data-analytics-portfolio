// ======================================================================
// Topic: Geospatial Polygons, Aggregation Math, and Range Filtering
// Databases: sample_airbnb, sample_mflix
// ======================================================================

// 1. Find the average nightly price for Airbnb listings in Hawaii.
// Using $geoWithin with a custom Polygon coordinates array.
db.listingsAndReviews.aggregate([
  {
    $match: {
      "address.location": {
        $geoWithin: {
          $geometry: {
            type: "Polygon",
            coordinates: [[
              [-160.1803979135296, 22.303946717779215],
              [-155.6934035238732, 18.794274136049378],
              [-154.13123530133325, 19.834780911601776],
              [-156.6477759278137, 21.470242707163155],
              [-159.9740532842532, 22.60069930475333],
              [-160.1803979135296, 22.303946717779215]
            ]]
          }
        }
      }
    }
  },
  {
    $group: {
      _id: "Hawaii_Average",
      avg_price: { $avg: "$price" }
    }
  },
  {
    $project: {
      _id: 0,
      avg_price: { $round: ["$avg_price", 2] }
    }
  }
]);
// Expected Result: { avg_price: 231.49 }

// ======================================================================

// 2a. Count movies with an IMDb rating > 8 released between 2015 and 2023.
db.movies.aggregate([
  {
    $match: {
      "imdb.rating": { $gt: 8 },
      year: { $gte: 2015, $lte: 2023 }
    }
  },
  { $count: "highly_rated_movies_count" }
]);
// Expected Result: 63

// 2b. Find the single movie with the highest rating from that same period.
db.movies.aggregate([
  {
    $match: {
      "imdb.rating": { $gt: 8 },
      year: { $gte: 2015, $lte: 2023 }
    }
  },
  { $sort: { "imdb.rating": -1 } },
  { $limit: 1 },
  {
    $project: {
      _id: 0,
      title: 1,
      rating: "$imdb.rating"
    }
  }
]);
// Expected Result: { title: "A Brave Heart: The Lizzie Velasquez Story", rating: 9.4 }
