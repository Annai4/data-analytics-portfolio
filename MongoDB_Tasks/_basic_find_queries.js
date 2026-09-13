// ======================================================================
// Topic: Basic Queries, Filtering, Sorting, and Projections
// Database: ich (Collections: customers, US_Adult_Income)
// ======================================================================

// 1. Find the city where "Sven Ottlieb" lives (Collection: customers).
// Using projection to return only the City field.
db.customers.find(
    { ContactName: "Sven Ottlieb" },
    { City: 1 }
);
// Expected Result: "Aachen"

// 2. Find the oldest person in the dataset (Collection: US_Adult_Income).
// Sorting by age in descending order (-1) and limiting to 1 result.
db.US_Adult_Income.find()
  .sort({ age: -1 })
  .limit(1);
// Expected Result: Age 90

// 3. Find how many people share this maximum age (90 years old).
db.US_Adult_Income.countDocuments(
    { age: 90 }
);
// Expected Result: 43

// 4. Find the _id of the document where education is " IT-career-hub".
db.US_Adult_Income.find(
    { education: " IT-career-hub" },
    { _id: 1 }
);
// Expected Result: ObjectId('656e13232afc911a8a7ad5e5')

// 5. Find the total number of people aged between 20 and 30 (inclusive).
db.US_Adult_Income.countDocuments(
    { age: { $gte: 20, $lte: 30 } }
);
// Expected Result: 8915
