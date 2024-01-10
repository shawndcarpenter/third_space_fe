import { Controller } from "@hotwired/stimulus";

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0,
};

export default class extends Controller {
  success(pos) {
    const crd = pos.coords;

    console.log("Your current position is:");
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude: ${crd.longitude}`);
    console.log(`More or less ${crd.accuracy} meters.`);

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch('/geolocation_storage/lat_lon_session', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ latitude: crd.latitude, longitude: crd.longitude })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      
      console.log(data);
    })
    .catch(error => console.error('There was a problem with the fetch operation:', error));
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  connect() {
    navigator.geolocation.getCurrentPosition(this.success, this.error, options);
  }

  search() {
    navigator.geolocation.getCurrentPosition(this.success, this.error, options);
  }
}

