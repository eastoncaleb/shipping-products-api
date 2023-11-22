# Shipping Products API

This Rails application serves as a backend API for managing shipping products. It utilizes MongoDB for data storage and provides RESTful endpoints for CRUD operations on shipping products.

## Features

- CRUD operations for shipping products
- Dimension-based product matching
- RESTful API serving JSON responses
- HTTP status code adherence
- Data validation
- Script to populate the database with initial data from `products.json`

## Prerequisites

- Ruby 3.2.2
- Rails 7.1.2
- MongoDB
- Bundler

## Local Setup

**From your terminal, perform the following:**
1. Clone the repository from Github e.g. `git clone <repository-url>`
2. Navigate into the repository folder e.g. `cd shipping_products_api`
3. Run `bundle install`
4. Create your database: `rails db:create`
5. Import data from your local products file: `rake db:import_products`

## Getting Started

Start your server: Run `rails server` in your terminal from within your project folder. The API will be available at `http://localhost:3000`.

## API Endpoints

### CREATE
POST `/api/v1/products`

**Example request body:**

```
{
  "name": "New Product",
  "type": "Golf",
  "length": 48,
  "width": 14,
  "height": 12,
  "weight": 42
}
```

### READ (all products)
GET `/api/v1/products`

### READ (find the matching product for given dimensions)
GET `/api/v1/products/match?length=x&width=y&height=z&weight=w`

**Example request:**

GET `/api/v1/products/match?length=48&width=14&height=12&weight=42`

### UPDATE
PATCH `/api/v1/products/:id`

**Example request body for updating product with id:**

```
{
  "name": "Updated Product"
}
```

### DESTROY

**Example request:**
DELETE `/api/v1/products/:id`

## Running Tests

To run the automated tests: `bundle exec rspec`

## Notes
- If you need assistance with installing ruby or rails, here is a great guide you can follow:
<https://gorails.com/setup/macos/>. The link defaults to MacOS but if you are running an alternative operating system such as Windows or Linux, simply click on the appropriate option under "Operating System".
- Ensure MongoDB is running before starting the server or running tests. If you need assistance with installing MongoDB,
here is a great guide you can follow: <https://www.mongodb.com/docs/manual/tutorial/>. Follow the link and click on the appropriate guide for your operating system.
- Repository URL: Replace <repository-url> with the actual URL of the backend repository.

