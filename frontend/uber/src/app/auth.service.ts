import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
// import { HttpClient } from '@angular/common/http';
@Injectable({
  providedIn: 'root'
})
export class AuthService {

    constructor(private http: HttpClient) {}

    private baseUrl = 'http://your-backend-api-url';

    // Dummy authentication logic (replace with actual API calls)
    private isAuthenticated = false;

  register(username: string, password: string): Observable<any> {
    const registrationData = { username, password };
    return this.http.post(`${this.baseUrl}/register`, registrationData);
  }

  login(username: string, password: string): Observable<any> {
    const loginData = { username, password };
    return this.http.post(`${this.baseUrl}/login`, loginData);
  }

    isAuthenticatedUser() {
    return this.isAuthenticated;
    }

    bookCab(bookingData: any): Observable<any> {
        return this.http.post(`${this.baseUrl}/book-cab`, bookingData);
    }
}
