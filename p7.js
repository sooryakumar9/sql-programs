// INSERT
// Insert a single document into the 'users' collection
db.users.insertOne({
    name: "John Doe",
    age: 30,
    email: "john.doe@example.com"
});

// Insert multiple documents into the 'users' collection
db.users.insertMany([
    {
        name: "Alice",
        age: 25,
        email: "alice@example.com"
    },
    {
        name: "Bob",
        age: 28,
        email: "bob@example.com"
    }
]);

// READ
// Find all documents in the 'users' collection
db.users.find();

// Find a specific document by a field
db.users.findOne({ name: "John Doe" });

// Find documents with a specific condition
db.users.find({ age: { $gt: 25 } });

//UPDATE
// Update a single document
db.users.updateOne(
    { name: "John Doe" },
    { $set: { age: 31 } }
);

// Update multiple documents
db.users.updateMany(
    { age: { $gt: 25 } },
    { $set: { status: "active" } }
);

// DELETE
// Delete a single document
db.users.deleteOne({ name: "John Doe" });

// Delete multiple documents
db.users.deleteMany({ age: { $lt: 30 } });
