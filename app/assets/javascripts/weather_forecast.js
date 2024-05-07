// app/assets/javascripts/weather_forecasts.js

$(document).ready(function() {
    $('#weatherForm').submit(function(e) {
      e.preventDefault(); // Prevent default form submission
      var zipCode = $('#zipCode').val(); // Get the zip code entered by the user
  
      // Make AJAX request to fetch weather forecast
      $.ajax({
        url: '/weather_forecasts',
        method: 'GET',
        data: { zip_code: zipCode },
        success: function(data) {
          // Update the page content with the fetched forecast data
          $('#forecastResult').html(data);
        },
        error: function(xhr, status, error) {
          // Handle errors if any
          console.error(error);
        }
      });
    });
  });
  