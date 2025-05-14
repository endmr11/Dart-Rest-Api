# Dart REST API Project

## Overview
This project is a simple command-line application built using Dart and the Alfred framework. It provides a RESTful API for managing orders, products, and user data.

## Features
- **Authentication**: Login and token refresh functionality.
- **Orders Management**: Create, read, update, and delete orders.
- **Products Management**: Retrieve all products and individual product details.
- **User Management**: Retrieve user details.

## Setup
1. Ensure you have Dart installed on your system.
2. Clone the repository.
3. Run `dart pub get` to install dependencies.
4. Configure the database and socket settings in the `config` directory.
5. Run the application using `dart bin/dart_api.dart`.

## API Endpoints
- **Login**: `POST /login`
- **Refresh Token**: `POST /refresh/token`
- **Orders**:
  - `GET /orders/all-orders`
  - `GET /orders/order/:id`
  - `GET /orders/my-orders/:id`
  - `POST /orders/order-create`
  - `PUT /orders/order-update/:id`
  - `GET /orders/order-delete/:id`
- **Products**:
  - `GET /products/all-products`
  - `GET /products/product/:id`
- **Users**:
  - `GET /users/user/:id`

## Middleware
- Authentication middleware is applied to all order, product, and user routes.

## Error Handling
- 404 Not Found responses are handled for undefined routes.

## License
This project is licensed under the MIT License.
