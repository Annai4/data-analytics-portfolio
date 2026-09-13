// ======================================================================
// Topic: Advanced Aggregations, Filtering, and the $out Stage
// Database: ich (Collection: Spotify_Youtube)
// ======================================================================

// 1. Find the track with the highest Danceability and Energy.
db.Spotify_Youtube.aggregate([
  { $sort: { Danceability: -1, Energy: -1 } },
  { $limit: 1 },
  { 
    $project: { 
      _id: 0, 
      Track: 1, 
      Danceability: 1, 
      Energy: 1 
    } 
  }
]);

// 2. Find the track with the longest duration (excluding compilations).
// Added $match to filter out 'compilation' as required by the task.
db.Spotify_Youtube.aggregate([
  { $match: { Album_type: { $ne: "compilation" } } },
  { $sort: { Duration_ms: -1 } },
  { $limit: 1 },
  { 
    $project: { 
      _id: 0, 
      Track: 1, 
      Duration_ms: 1 
    } 
  }
]);

// 3. Find the single album that contains the highest number of tracks.
db.Spotify_Youtube.aggregate([
  { $match: { Album_type: "album" } },
  {
    $group: {
      _id: "$Album",
      cnt_tracks: { $sum: 1 }
    }
  },
  { $sort: { cnt_tracks: -1 } },
  { $limit: 1 }
]);

// 4. Find the number of YouTube views for the track with the most Spotify streams.
db.Spotify_Youtube.aggregate([
  { $sort: { Stream: -1 } },
  { $limit: 1 },
  { 
    $project: { 
      _id: 0, 
      Track: 1, 
      Stream: 1, 
      Views: 1 
    } 
  }
]);

// ======================================================================
// 5. Exporting Top 20 tracks to a different database using $out
// ======================================================================

// 5a. Top 20 most viewed tracks on YouTube -> Export to ich_edit
db.Spotify_Youtube.aggregate([
  { $sort: { Views: -1 } },
  { $limit: 20 },
  { 
    $out: { 
      db: "ich_edit", 
      coll: "top20youtube_Hanna_Ivanova" 
    } 
  }
]);

// 5b. Top 20 most streamed tracks on Spotify -> Export to ich_edit
db.Spotify_Youtube.aggregate([
  { $sort: { Stream: -1 } },
  { $limit: 20 },
  { 
    $out: { 
      db: "ich_edit", 
      coll: "top20spotify_Hanna_Ivanova" 
    } 
  }
]);
