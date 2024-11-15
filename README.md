# Band Finder Backend API

A Rails API to help users search for music bands that were founded in a given location within the last 10 years. This backend API integrates with the MusicBrainz API to fetch band data, allowing users to search for bands based on location.

## Features

- **Search Bands by Location:** Fetch bands that were founded in a specific city within the last 10 years.
- **Location Detection:** Automatically detects the user’s location and provides band data for their location by default.
- **Third-Party API Integration:** Integrates with the [MusicBrainz API](https://musicbrainz.org/doc/MusicBrainz_API) to fetch band data.
- **CORS Configuration:** Allows frontend applications to communicate with this API by whitelisting specific origins.

## Technologies Used

- Ruby on Rails (API mode)
- PostgreSQL (Database)
- MusicBrainz API (Third-party service)
- HTTParty (For making API requests)
- Puma (Web server)
- Rack-CORS (For handling CORS issues)

## Setup Instructions

### Prerequisites

- Ruby 3.x+
- Rails 6.x+
- PostgreSQL installed locally or use a managed service like Render for production.
- A MusicBrainz API account to get access to their services.

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/band-finder-backend.git
   cd band-finder-backend
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Set up the database**:

   Make sure you have PostgreSQL installed and running. Then run:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Set the `RAILS_MASTER_KEY`**:

   If you're using Rails credentials, you will need to set the `RAILS_MASTER_KEY` in your environment:

   ```bash
   export RAILS_MASTER_KEY=<your_master_key>
   ```

   Alternatively, set the environment variable on your hosting platform (e.g., Render).

5. **Configure the MusicBrainz API**:

   This app interacts with the MusicBrainz API. You should configure it with your MusicBrainz credentials (if needed) in `config/credentials.yml.enc`.

6. **Configure CORS**:

   The backend is set up to allow requests from specific origins. You can whitelist your frontend application by updating the `config/application.rb` file with the following configuration:

   ```ruby
   config.middleware.insert_before 0, Rack::Cors do
     allow do
       origins 'https://band-finder-frontend.onrender.com'  # Your frontend URL
       resource '*', 
                headers: :any, 
                methods: [:get, :post, :put, :patch, :delete, :options, :head]
     end
   end
   ```

   Make sure to replace `'https://band-finder-frontend.onrender.com'` with your actual frontend URL.

### Running the Application Locally

1. **Start the Rails server**:

   ```bash
   bundle exec puma -t 5:5 -p 3000
   ```

2. **Access the API**:

   The app will run on [http://localhost:3000](http://localhost:3000) by default. You can use tools like Postman or cURL to test the API.

### Available Endpoints

- **GET /api/v0/bands**  
  Search for bands by location.  
  Parameters:
  - `location` (required): City or area name.
  - `founded_since` (optional): Year since the bands should be founded (default is the last 10 years).
  - `limit` (optional): Number of results to fetch (default is 50).

  Example Request:
  ```bash
  GET /api/v0/bands?location=New York
  ```

  Example Response:
  ```json
  {
    "bands": [
      {
        "name": "Band Name",
        "location": "New York",
        "founded": "2014"
      },
      ...
    ]
  }
  ```

### Deployment

1. **Deploy on Render** (Recommended):

   - Set up the project as a Rails application on [Render](https://render.com).
   - Set environment variables:
     - `RAILS_MASTER_KEY` (from your `config/master.key`).
     - `DATABASE_URL` (PostgreSQL connection URL).
   - Deploy the application and connect to the PostgreSQL database.

   For more detailed deployment instructions, check the [Render Documentation](https://render.com/docs).

### Testing

Test cases are not included yet. To add tests, use RSpec for unit and integration tests for the API.

### Notes

- This app is integrated with the [MusicBrainz API](https://musicbrainz.org/doc/MusicBrainz_API) to fetch band data based on the user's location and founded year.
- CORS is configured to allow frontend apps hosted on `https://band-finder-frontend.onrender.com` to communicate with this API.

---

### Improvements

If I had more time, I would consider the following improvements:

- **Add Proper Test Cases**: Implement RSpec tests for all controllers, models, and services to ensure full test coverage.
- **Cache Frequently Searched Locations**: To reduce the number of calls to the MusicBrainz API, we could implement caching for frequently searched cities. This would improve performance and reduce external API calls.
- **Database Caching**: We could also cache the band data in our own database. If data for a location already exists in the database, the API could simply return the cached results instead of making a call to MusicBrainz.
- **Periodic Job to Update Cached Data**: Set up a periodic job (e.g., using Sidekiq or ActiveJob) to periodically update our database with the latest band data. This would ensure that our cache remains fresh and accurate without overloading the MusicBrainz API with frequent requests.

---

### Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

---

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This `README.md` now includes an "Improvements" section to highlight potential future enhancements for the backend app. Let me know if you need further refinements or additions!
