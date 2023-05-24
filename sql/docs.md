**Title: Guide to Database Tables and Queries**

## Introduction
This guide provides an overview of the database structure and includes template queries for inserting and updating data in the tables. The database consists of three tables: "accounts", "websites", and "statistics". Each table serves a specific purpose and contains relevant fields to store the required information. Below, we will explore the structure of each table, explain the fields, and provide template queries for common operations.

### Table: `accounts`
The `accounts` table stores user account information.

#### Fields:
- `accountId` (INT): Unique identifier for each account.
- `username` (VARCHAR): The username associated with the account. Must be unique.
- `password` (VARCHAR): The encrypted password for the account.
- `email` (VARCHAR): The email address associated with the account. Must be unique.
- `status` (ENUM): Represents the account status, which can be 'inactive', 'active', or 'banned'.
- `subscription` (ENUM): Indicates the subscription level, which can be 'free' or 'corporate'.
- `lastModified` (TIMESTAMP): Records the timestamp when the account was last modified.

#### Template Queries:
##### Insert Data:
```sql
INSERT INTO accounts (username, password, email, status, subscription) 
VALUES ('{username}', '{password}', '{email}', '{status}', '{subscription}');
```

##### Update Data:
```sql
UPDATE accounts SET 
    username = '{newUsername}',
    email = '{newEmail}',
    status = '{newStatus}',
    subscription = '{newSubscription}'
WHERE accountId = {accountId};
```

### Table: `websites`
The `websites` table stores information about websites associated with user accounts.

#### Fields:
- `webId` (INT): Unique identifier for each website.
- `accountId` (INT): The account ID associated with the website.
- `name` (VARCHAR): The name of the website.
- `url` (VARCHAR): The URL of the website.
- `status` (ENUM): Represents the status of the website, which can be 'active' or 'inactive'.
- `visibility` (ENUM): Indicates the visibility of the website, which can be 'public' or 'private'.
- `lastModified` (TIMESTAMP): Records the timestamp when the website was last modified.

#### Template Queries:
##### Insert Data:
```sql
INSERT INTO websites (accountId, name, url, status, visibility) 
VALUES ({accountId}, '{name}', '{url}', '{status}', '{visibility}');
```

##### Update Data:
```sql
UPDATE websites SET 
    name = '{newName}',
    url = '{newUrl}',
    status = '{newStatus}',
    visibility = '{newVisibility}'
WHERE webId = {webId};
```

### Table: `statistics`
The `statistics` table stores statistical information related to websites.

#### Fields:
- `webId` (INT): The ID of the website associated with the statistics.
- `date` (DATE): The date of the statistics.
- `upvote` (INT): The number of upvotes for the website.
- `downvote` (INT): The number of downvotes for the website.
- `uptime` (FLOAT): The calculated percentage of upvotes considering total upvotes and downvotes.
- `lastModified` (TIMESTAMP): Records the timestamp when the statistics were last modified.

#### Template Queries:
##### Insert Data:
```sql
INSERT INTO statistics (webId, date, upvote, downvote) 
VALUES ({webId}, '{date}', {upvote}, {downvote});
```

##### Update Data:
```sql
UPDATE statistics SET 
    upvote = {newUpvote},
    downvote = {newDownvote}
WHERE webId = {webId} AND date = '{date}';
```

## Conclusion
This guide provides an overview of the database structure and includes template queries for inserting and updating data in the "accounts", "websites", and "statistics" tables. You can use these templates as a starting point and customize them according to your specific requirements. By utilizing these queries, you can efficiently manage data within your database.

If you have any further questions or need additional support, please don't hesitate to reach out.

Happy coding!