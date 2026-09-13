// ======================================================================
// Topic: Aggregation Pipeline, Data Insertion, and Grouping
// Database: ich / Custom
// ======================================================================

// 1. Find the average age in the US_Adult_Income collection.
db.US_Adult_Income.aggregate([
  {
    $group: {
      _id: null,
      average_age: { $avg: "$age" }
    }
  }
]);
// Expected Result: ~38.6

// ======================================================================
// Switch to custom database and create a new collection for orders
// ======================================================================

// 2. Insert data into the new orders collection.
db.orders_Hanna_Ivanova.insertMany([
  { id: 1, customer: "Olga",  product: "Apple",  amount: 15.55, city: "Berlin" },
  { id: 2, customer: "Anna",  product: "Apple",  amount: 10.05, city: "Madrid" },
  { id: 3, customer: "Olga",  product: "Kiwi",   amount: 9.6,   city: "Berlin" },
  { id: 4, customer: "Anton", product: "Apple",  amount: 20,    city: "Roma" },
  { id: 5, customer: "Olga",  product: "Banana", amount: 8,     city: "Madrid" },
  { id: 6, customer: "Petr",  product: "Orange", amount: 18.3,  city: "Paris" }
]);

// 3. Find the total number of purchases made.
db.orders_Hanna_Ivanova.countDocuments();
// Expected Result: 6

// 4. Find how many times apples were purchased.
db.orders_Hanna_Ivanova.aggregate([
  { $match: { product: "Apple" } },
  { $count: "total_apples" }
]);
// Expected Result: 3

// 5. Output the IDs of the top 3 most expensive purchases.
db.orders_Hanna_Ivanova.aggregate([
  { $sort: { amount: -1 } },
  { $limit: 3 },
  { $project: { _id: 1, amount: 1 } }
]);

// 6. Find the total number of purchases made in Berlin.
db.orders_Hanna_Ivanova.countDocuments(
  { city: "Berlin" }
);
// Expected Result: 2

// 7. Find the number of times apples were purchased in Berlin and Madrid.
db.orders_Hanna_Ivanova.aggregate([
  { 
    $match: { 
      product: "Apple", 
      city: { $in: ["Berlin", "Madrid"] } 
    } 
  },
  { $count: "apple_purchases_in_cities" }
]);
// Expected Result: 2

// 8. Find the total amount spent by each customer.
db.orders_Hanna_Ivanova.aggregate([
  {
    $group: {
      _id: "$customer",
      total_spent: { $sum: "$amount" }
    }
  },
  {
    $project: {
      _id: 0,
      customer_name: "$_id",
      total_spent: 1
    }
  }
]);

// 9. Find the cities where Olga made purchases.
db.orders_Hanna_Ivanova.aggregate([
  { $match: { customer: "Olga" } },
  { $group: { _id: "$city" } }
]);
// Expected Result: 'Berlin', 'Madrid'
