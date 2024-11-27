# User Albums Viewer  

This is a simple app with two screens that allows users to view their albums and photos. The app fetches data 
from APIs to display a user's profile, albums, and album details with a search functionality for filtering images by title.  

---

## Features  

### 1. Profile Screen  
- Displays the **user's name** and **address** at the top.  
- Lists all albums associated with the user.  
- Fetches albums via the `albums` API endpoint by passing the `userId` as a parameter.  

### 2. Album Details Screen  
- Navigates to this screen when an album is selected from the Profile Screen.  
- Displays the album's images in an **Instagram-like grid layout**.  
- Fetches images via the `photos` API endpoint by passing the `albumId` as a parameter.  
- Includes a **search bar** for filtering images based on their title. As you type, only images matching the query are displayed.  
