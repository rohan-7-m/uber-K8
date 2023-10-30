import { Component } from '@angular/core';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent {
  user = {
    username: '',
    password: ''
  };

  constructor(private authService: AuthService) {}

  register() {
    this.authService.register(this.user.username,this.user.password).subscribe(response => {
      console.log(response);
      // Handle the registration response
    });
  }
}
