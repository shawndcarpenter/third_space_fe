
![Screenshot 2024-01-12 at 12 52 17](https://github.com/shawndcarpenter/third_space_fe/assets/139706925/13ba53ac-448b-46f8-a100-7bac4f745461)

# Third Space
> This product aims to help users find locations for leisure activities near them which fit their mood and needs.

The third place is disappearing; a physical location to go to between work/school and home. This application aims to help people find a sense of connection by allowing users to input their current mood and likes with a response of places that may help them find a sense of inclusion (or just help them destress from their daily lives).


## Installation

OS X & Linux:
This project runs on Rails 7.0.8.

Fork and clone [this repository](https://github.com/shawndcarpenter/third_space_fe), which is the front-end of our application.

Fork and clone [this repository](https://github.com/shawndcarpenter/third_space_be) to access our back-end.

Windows:

This product is not compatible with Windows.

## API
SIGN UP for a FREE TomTom API Key to access the locations through the back-end API calls [here](https://developer.tomtom.com/user/register).


## Why Use Third Space?

There are plenty of people who, for a variety of reasons, may wish to find a location to relax beyond their home. This application takes into account the following needs:
1. Mood
2. Accessibility Needs
3. Money the user wishes to spend
4. Whether the space is sober

## Moods Accounted For
1. Calm
2. Studious
3. High Energy
4. Loud
5. Quiet
6. Relaxed
7. Friendly

To provide feedback (including ideas for other moods to be added to our list), contact one of our members in the Staff list below or create a pull request using the instructions outlined in Contributing.

## What Can This Do?
Third Space can provide a list of locations based on a number of criteria indicated by the user. 

### Landing/Log In

Users can create an account using their email. This product includes 2 Factor Authentication via [rotp](https://github.com/mdp/rotp).
Once an account has been made, the user will be able to login and see their User Dashboard.
OmniAuth was utilized to allow for login through Google.

### User dashboard
The user will find a Recommended Locations section, which lists a selection of the 5 closest locations that match the user's current mood/needs.

The Saved Locations section will list locations previously saved by a user.

### Indices
The user can also access a larger number of locations near them by clicking on "See All" under the Recommended Locations or Saved Locations sections.

### Adding Moods
The most important part of this product is the ability to add moods to locations. When a user visits a page for a specific location, they are invited to add the moods that they experienced while in this location. Over time, the mood data will become more robust as more locations are reviewed. This application will organize the moods in order of the most commonly reported mood to least common. So, if 20 people experience a Relaxed mood and 2 experience a Loud mood, the Relaxed mood will be shown first. Given that there are no moods with more reports, Relaxed will be listed as the "Top Mood" for a location, and this will be displayed under the location name on all pages listing the location.

<img width="548" alt="Screenshot 2024-01-12 at 12 54 23" src="https://github.com/shawndcarpenter/third_space_fe/assets/139706925/0da72ae4-3f06-4d4a-bfae-c895711ff8c3">

## Development setup
Download both our [front end](https://github.com/shawndcarpenter/third_space_fe) and [back end](https://github.com/shawndcarpenter/third_space_be) applications.

Start the server on the back end and front end applications by typing the following in the terminal of both.

```sh
rails s
```

NOTE: The back-end application should be running on PORT 5000,
while the front-end application should be running on PORT 3000.


Run the following code in your terminal to install the gems required to use this application:
```sh
bundle install
```

Check to make sure all the tests are passing by running the following code in your terminal:
```sh
bundle exec rspec
```

## Gem Information
The front end repository handles most of what the user will interact with, including routing and page rendering. 

[Geocoder](https://github.com/alexreisner/geocoder) was used to provide geolocation

[Omniauth](https://github.com/omniauth/omniauth) was used for Oauth. 

[Bootstrap](https://github.com/twbs/bootstrap-rubygem) was used extensively for design on the front end.

Example of bootstrap code
```    <form class="d-flex w-50" action="/third_spaces/search" method="get" name="name" id="name">
      <input class="form-control me-2" id="name" name="name" type="text" placeholder="search by name" aria-label="Search" style="flex-grow: 1;">
      <button class="btn btn-outline-success" type="submit" style="margin-right: 2rem;">Search</button>
    </form>
```

### Testing
Our application includes extensive testing using the [Capybara gem](https://github.com/teamcapybara/capybara) to simulate user input and interaction.

This application also uses the [Launchy Gem](https://github.com/copiousfreetime/launchy) to view pages in the browser without needing to start the server.

The [Shoulda Matchers Gem](https://github.com/thoughtbot/shoulda-matchers) is used for one-liner testing of models.

The [Orderly Gem](https://github.com/jmondo/orderly) is used to check the order in which items appear on the pages for our application.

The [SimpleCov Gem](https://github.com/simplecov-ruby/simplecov) provides test coverage analysis for our application.

The [FactoryBot](https://github.com/thoughtbot/factory_bot) and [Faker Gems](https://github.com/faker-ruby/faker) was used to create large amounts of data for testing. 

The [Rails Controller Testing](https://github.com/rails/rails-controller-testing) gem was used to test some controller actions, such as `assign` to access instance variables  and `assert` to make sure certain templates were rendered

The back end handles API calls to the TomTom API as well as accepts post requests from the user for location moods. It simulates API calls using the [WebMock gem](https://github.com/bblimke/webmock) and the [VCR gem](https://github.com/vcr/vcr).

Both use the [Pry gem](https://github.com/pry/pry) and [RSpec Rails](https://github.com/rspec/rspec-rails) within the testing environment for unit and feature testing.

In the testing environment, a static OTP code was used. 

## Staff

Main Support Email: thirdspace2308@gmail.com

Shawn Carpenter: [Email](shawncarpenter.co@gmail.com) [LinkedIn](https://www.linkedin.com/in/shawndcarpenter/)

Brendan Bondurant: [Email](bondurant.brendan@gmail.com) [LinkedIn](https://www.linkedin.com/in/brendanbondurant/)

Nathan Trautenberg: [Email](ntrautenberg23@gmail.com) [LinkedIn](https://www.linkedin.com/in/nathan-trautenberg-9106271a7/)

Anthea Yur: [Email]() [LinkedIn](https://www.linkedin.com/in/antheayur/)

Charles Ren [Email]() [LinkedIn](https://www.linkedin.com/in/charles-ren-code/)

## Contributing

1. Fork it (<https://github.com/shawndcarpenter/third_space_fe>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request


