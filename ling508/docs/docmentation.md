# API Documentation for STIX-D Clex Importer

This document provides an overview of the API endpoints for the STIX-D Clex Importer Flask application. It describes the expected inputs, outputs, and usage for the implemented use case.

## Base URL

`http://localhost:5000`


## Endpoints

### Import Clex Entries

**Endpoint:**
POST /import_clex


**Description:**
Imports entries from a Clex file provided via a URI into the STIX-D corpus database.

**Request:**

- **Content-Type:** `application/json`
- **Body:**
  ```json
  {
      "uri": "https://example.com/path/to/clex/file"
  }

**Response:**

- **Content-Type:** `application/json`
- **Body:**
  ```json
  {
    "status": "success",
    "message": "Clex entries imported successfully.",
    "stix_object_id": "x-stixd-clex--46eee763-676a-4324-9384-16bdb984bf1b",
    "imported_entries_count": 60
  }
  ```

**Error Response:**

- **Content-Type:** `application/json`
- **Body:**
  ```json
  {
    "status": "error",
    "message": "An error occurred while importing Clex entries."
  }
  ```

**Example Usage:**
***Using Postman***

1. Open Postman
1. Create a new `POST` request.
1. Set the URL to `http://localhost:5000/import_clex`.
1. Set the request body to:
  ```json
  {
      "uri": "https://example.com/path/to/clex/file"
  }
  ```
1. Send the request and check the response for success or error messages.

***Using cURL***
```bash
curl -X POST http://localhost:5000/import_clex -H "Content-Type: application/json" -d '{"uri": "https://example.com/path/to/clex/file"}'
```

### Notes
- Ensure the Flask server is running before making requests.
- The uri provided should be a valid link to a Clex file.
- This documentation covers the main use case for importing Clex entries. Additional endpoints and features can be added as needed.

## Form HTML
The following is a sample HTML form for users to input the URI of a Clex file and submit it to the /import_clex endpoint.
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clex Importer</title>
</head>
<body>
    <h1>Import Clex Entries</h1>
    <form action="/import_clex" method="post">
        <label for="uri">Clex File URI:</label>
        <input type="text" id="uri" name="uri" required>
        <button type="submit">Import</button>
    </form>
</body>
</html>
```

## Conclusion
This documentation provides the necessary information to use the STIX-D Clex Importer API. It includes details on how to import Clex entries via the Flask API and an example HTML form for user interaction.