# SpaceX_Fan

## About

SpaceX Fan app shows the status (i.e, upcoming/launched rocket informataion) of the rockets of SpaceX Fan program. 

## Features

1. SignIn
2. Create Account
3. Show list of rockets
4. List of your liked rockets i.e, Favorites 
5. List of upcoming rockets

## Technologies Used

1. SignIn/Create account -> Firebase authentication
2. Image downloading -> SDWebImage 
3. Favorites -> Firebase FireStore
4. Analytics -> Firebase Analytics

Other technologies Used: FaceId/Fingerprint for two factor authentication, IQKeyboardManagerSwift for showing toolbar on keyboard.

## Flow

Splash -> All rockets screen 
All rocktes screen (Favorite click action) :

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Signup dailogue (If not signed in)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Two factor authentication (If not authenticated, After launch)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Favorite action i,e. Favorite/ Unfavorite (Signed in and authenticated)
                
Favorite rocets screen :

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Signup dailogue (If not signed in)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Two factor authentication (If not authenticated, After launch)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Favorite action/ Swipe right to left i,e. Remove from favorites list (Signed in and authenticated)

Upcoming rockets screen :

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Signup dailogue (If not signed in)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Two factor authentication (If not authenticated, After launch)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Favorite action i,e. Favorite/ Unfavorite (Signed in and authenticated)

Signup dailogue 
                        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Sign In button clcik -> Sign In screen

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Create account button click -> Create account screen

Sign In/ Creat account -> Home screen 


## Credits 

1. Icons taken from [flaticon](http://flaticon.com/)
2. Api used from [SpaceX-API](https://github.com/r-spacex/SpaceX-API)

## Licence 

[MIT License](https://choosealicense.com/licenses/mit/#)

```
Copyright (c) [2021] [Vinod Neeloju]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 
```


                                           
