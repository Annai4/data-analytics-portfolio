// ======================================================================
// Topic: Regular Expressions (Regex) and Array Aggregations
// Database: Custom (Collection: sample_data.restaurants)
// ======================================================================

// 1. Find restaurants in 'Staten Island' that have the word 'pizza' in their name.
// Using $regex with the 'i' option for case-insensitive matching.
db.restaurants.find({
  borough: "Staten Island",
  name: { $regex: /pizza/i }
});

// 2. Find the top 5 restaurants based on their average grade score.
// The grades field is an array of objects, so we calculate the average directly inside a projection.
db.restaurants.aggregate([
  {
    $project: {
      _id: 0,
      name: 1,
      avg_score: { $avg: "$grades.score" }
    }
  },
  { $sort: { avg_score: -1 } },
  { $limit: 5 }
]);
