// ======================================================================
// Topic: Array Querying ($size), Existence Checks, and Sorting
// Database: ich (Collections: imdb, bookings)
// ======================================================================

// 1. Find movies written by exactly 3 writers and directed by exactly 2 directors.
db.imdb.find(
    { writers: { $size: 3 }, directors: { $size: 2 } },
    { _id: 0, title: 1, writers: 1, directors: 1 }
);

// Count the total number of such movies (Expected result: 483).
db.imdb.countDocuments(
    { writers: { $size: 3 }, directors: { $size: 2 } }
);

// 2. Find the final address of a specific car (by VIN) on its most recent trip.
// Filtering out documents where the final address is missing or empty.
db.bookings.find(
    { 
        vin: "WME4530421Y135045", 
        final_address: { $exists: true, $ne: "" } 
    },
    { _id: 0, final_address: 1, final_date: 1 }
).sort({ final_date: -1, final_time: -1 }).limit(1);

// 3. Count how many times cars ended their rental with completely empty fuel.
db.bookings.countDocuments(
    { final_fuel: 0 }
);

// 4. Find the license plate and VIN of the car with the maximum distance traveled.
db.bookings.find(
    {}, 
    { _id: 0, vin: 1, license_plate: 1, distance: 1 }
).sort({ distance: -1 }).limit(1);

// 5. Find the highest-rated movie featuring "Brad Pitt".
// Using $type: "number" to ensure we only sort valid numerical ratings.
db.imdb.find(
    { 
        cast: "Brad Pitt", 
        "imdb.rating": { $type: "number" } 
    }, 
    { _id: 0, title: 1, year: 1, "imdb.rating": 1 }
).sort({ "imdb.rating": -1 }).limit(1);
