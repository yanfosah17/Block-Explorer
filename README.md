# README

# 🚀 Block Explorer

Block Explorer is a simple Ruby on Rails application that fetches and displays transfer transactions from a simulated NEAR blockchain using a mock API. It stores transactions locally, ensuring historical data remains available even if it is no longer returned by the API.

---

## 📌 Features
- Fetches **transfer transactions** from the NEAR blockchain API.
- Stores transactions locally using **PostgreSQL**.
- Displays historical transactions even if they are no longer returned by the API.
- Simple and clean UI to view sender, receiver, deposit amount, and block information.
- Provides feedback on whether the API is available or down.

---

## 🛠️ Prerequisites

Ensure you have the following installed:
- **Ruby** (>= 3.0.0)
- **Rails** (>= 7.0)
- **PostgreSQL** (Ensure it's running locally)
- **Bundler** (if not installed, run `gem install bundler`)

---

## 📥 Installation and Setup

Follow these steps to clone and run the app:

1. **Clone the Repository**
    ```bash
    git clone git@github.com:yanfosah17/Block-Explorer.git
    cd Block-Explorer
    ```

2. **Install Dependencies**
    ```bash
    bundle install
    ```

3. **Set Up the Database**
    ```bash
    rails db:create
    rails db:migrate
    ```

4. **Run the Server**
    ```bash
    rails server
    ```

5. **Access the Application**
    - Open your browser and navigate to:  
      [http://localhost:3000](http://localhost:3000)

---

## 🧪 Running Tests

To run the test suite:
```bash
rails test
```
