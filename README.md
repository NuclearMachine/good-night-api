# Good Night API

Good Night API is a Rails API-only application that allows users to track their sleep records and follow other users. Users can view sleep records of the people they follow, ordered by sleep duration.

## Prerequisites

- Ruby version: 2.7.0 or higher
- Rails version: 7.0.0 or higher
- PostgreSQL

## Installation

1. Clone the repository:

```shell
git clone https://github.com/nuclearmachine/good-night-api.git
cd good-night-api
```

2. Install dependencies:

```shell
bundle install
```

3. Create and set up the database:

```shell
rails db:create db:migrate
```

4. Start the Rails server:

```shell
rails s
```

## API Endpoints

The base URL for all API endpoints is `/api/v1`.

### Authentication

Don't forget to append the authentication headers to your requests when accessing protected API endpoints. This API uses [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth) for user authentication. Users must include the authentication headers in their requests to access protected endpoints.

When you sign in, the server will return authentication headers in the response. To access protected API endpoints, you need to include these headers in your request. Here's an example of how to include authentication headers in a request to create a sleep record:

1. Sign in and obtain the authentication headers:

```shell
curl -X POST http://localhost:3000/api/v1/auth/sign_in \
  -H 'Content-Type: application/json' \
  -d '{
        "email": "test@example.com",
        "password": "password"
      }' -i
```

The response will include the following headers:

* `access-token`
* `client`
* `expiry`
* `uid`


Create a sleep record by including the authentication headers in your request:

```shell
curl -X POST http://localhost:3000/api/v1/sleep_records \
  -H 'Content-Type: application/json' \
  -H 'access-token: YOUR_ACCESS_TOKEN' \
  -H 'client: YOUR_CLIENT' \
  -H 'expiry: YOUR_EXPIRY' \
  -H 'uid: YOUR_UID' \
  -d '{
        "start_time": "2023-03-15T22:00:00Z",
        "end_time": "2023-03-16T06:00:00Z"
      }'
```

Replace `YOUR_ACCESS_TOKEN`, `YOUR_CLIENT`, `YOUR_EXPIRY`, and `YOUR_UID` with the values you received in the sign-in response. By including these headers, the server will recognize the authenticated user and allow them to create a sleep record.

To obtain authentication headers, users must first sign in or sign up:

#### Sign Up

- `POST /api/v1/auth`
- Required parameters: `email`, `password`, `password_confirmation`

#### Sign In

- `POST /api/v1/auth/sign_in`
- Required parameters: `email`, `password`

### Sleep Records

#### Create Sleep Record

- `POST /api/v1/sleep_records`
- Required parameters: `start_time`, `end_time`
- Requires authentication

#### List Sleep Records

- `GET /api/v1/sleep_records`
- Requires authentication

### Followings

#### Follow User

- `POST /api/v1/followings`
- Required parameters: `followed_id` (target user to be followed)
- Requires authentication

#### Unfollow User

- `DELETE /api/v1/followings/:id`
- Requires authentication

### Friends' Sleep Records

#### List Friends' Sleep Records (past week)

- `GET /api/v1/friends_sleep_records`
- Requires authentication

## Running Tests

This project includes a comprehensive suite of tests for both models and controllers using RSpec. These tests help ensure the functionality and reliability of the application. To run the test suite, execute:

```shell
bundle exec rspec
```

## Support

If you encounter any issues or have questions regarding the usage of this API, feel free to contact me at my email: tapiador@jibril.ch. I'll be happy to assist you.

## サポート

このAPIの使用に関する問題や質問がある場合は、お気軽に私のメールアドレス（tapiador@jibril.ch）までご連絡ください。喜んでお手伝いします。

