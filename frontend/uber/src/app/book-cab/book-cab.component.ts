import { Component } from '@angular/core';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-book-cab',
  templateUrl: './book-cab.component.html',
  styleUrls: ['./book-cab.component.scss']
})
export class BookCabComponent {
  bookingData = {
    name: '',
    phoneNumber: '',
    pickupLocation: '',
    destination: '',
    vehicleType: 'sedan' // Default to 'Sedan'
  };

  constructor(private authService: AuthService) {}

  bookCab() {
    console.log('Booking Data:', this.bookingData);
    this.authService.bookCab(this.bookingData).subscribe(response => {
      // Handle the booking response
      console.log(response);
    });
  }
}
