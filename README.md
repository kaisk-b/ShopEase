# ShopEase

ShopEase is a Flutter-based e-commerce application designed as a modern, scalable shopping experience with a Supabase backend foundation. The project focuses on building a clean product browsing flow, cart management, authentication UI, and a custom animated navigation experience.

The app is currently in active development and is being built step by step with a focus on learning real-world mobile/web app architecture, state handling, UI composition, backend integration, and clean code organization.

## Overview

ShopEase is designed to simulate the core experience of a production e-commerce application. It includes a product catalog, shopping cart flow, welcome/login/signup screens, and a custom spotlight-style bottom navigation bar inspired by modern mobile UI trends.

The frontend is built using Flutter, while Supabase is used as the backend platform for database, authentication, and future order management features.

## Features

- Modern Flutter UI for an e-commerce product catalog
- Product listing using reusable product card components
- Cart system with item count and total price calculation
- Cart bottom sheet with item preview, clear cart, and checkout actions
- Welcome, login, and sign-up screens with polished gradient UI
- Custom animated spotlight bottom navigation bar
- Supabase backend setup with a `products` table
- Beginner-friendly but scalable project structure
- Prepared for future Supabase Auth and database-driven product loading

## Tech Stack

- **Frontend:** Flutter
- **Language:** Dart
- **Backend:** Supabase
- **Database:** PostgreSQL via Supabase
- **Platform Targets:** Web first, Android support planned
- **Version Control:** Git and GitHub

## Current Status

The project currently has a functional UI prototype with local product data and cart logic. Supabase has been prepared as the backend database layer, and the next development phase is to replace local product data with live data fetched from Supabase.

## Planned Improvements

- Fetch products directly from Supabase
- Implement Supabase authentication for login and signup
- Store cart and order data in the backend
- Add product images and categories
- Add search and filtering
- Add product details screen
- Add user profile and order history
- Improve mobile responsiveness
- Refactor code into models, screens, widgets, and services
- Add admin/product management features
- Integrate real payment flow in future versions

## Project Goal

The goal of ShopEase is not only to build an e-commerce application, but also to understand how real-world Flutter apps are structured. The project is being developed incrementally, focusing on clean UI, reusable widgets, backend integration, navigation flow, and maintainable architecture.

## Getting Started

Clone the repository:

```bash
git clone https://github.com/kaisk-b/ShopEase.git
