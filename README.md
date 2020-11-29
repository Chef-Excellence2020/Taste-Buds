Taste Buds
===


## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)
1. [Networking](#Networking)
1. [Walkthrough](#Walkthrough)

## Overview
### Description
A recipe app that focuses on collaborative creation. Users can suggest alternative or replacement ingredients and instructions that are adopted into the recipe once approved.  This allows others with dietary concerns and those looking for different flavors more accessibility to more recipes.

### App Evaluation
- **Category:** Social Networking / Food
- **Mobile:**  The app will be created with mobile in mind, but could easily be adapted for web browsers if successful.
- **Story:** Allows users to build upon each others' recipes by commenting novel approaches that can then be intigrated into the original recipe.
- **Market:** Any individual could choose to use this app, and to keep it a safe environment, people would be organized into age groups.
- **Habit:** This app can be used by people who are looking for more options and freedom for their cooking. Cooks with special dietary concerns could also suggest alternative ingredients to existing meals to give others more options.
- **Scope:** After the base features are implemented, it will be important to create organization features that allow people to seek out specific recipes based on their needs. For example, if a suggestion makes a recipe gluten free, then the recipe needs to be updated in a way that it is findable by those looking for gluten free recipes.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* User logs in to access feed of recipes based on who they are following and/or recipe features that they like (type of meal, cooking time, difficulty, dietary concerns, etc.).
* User has a profile where they can create recipes and save their favorites
* User can make suggestions on recipes from other users, conversly, users can evaluate suggestions made by others and intigrate them into their recipes
* Comment section that allows users to rate and evaluate the quality of recipes that don't invovle changing the recipes
* General feed to discover new users and recipes

**Optional Nice-to-have Stories**
* Notifications when people you follow post new recipes
* Robust filtering system that allows users to efficently discover recipes based on their needs
* Intigrated cooking assistant utilities (timer, safe cooking temperatures, information on uncommon techniques, grocery list builder)
* Pintrest-esque shareable collections of recipes

**Mini Goals!**
- [x] User can log in.
- [x] User can log out.
- [x] User stays logged in across restarts.
- [ ] User can log in with Google account.
- [ ] User can post recipes.
- [ ] User can edit profile.
- [ ] User can view other recipes and profiles.

### 2. Screen Archetypes
* Login / Register
* Focused feed
   * Shows users recipes based on followed users and preferences
   * User can create new recipe here
* Discovery feed
    * Allows users to discover new recipes based on more general preferences
* Profile Screen 
   * User can evalute suggestions made to them
   * User can edit relevant aspects of their profile
   * a potential secondary or primary locaiton to create new recipes
* Recipe page
    * User can view ingredients, instructions, and other relevant material
    * User can save a recipe to a special collection tied to their profile
    * User can rate quality and difficulty of the recipe and comment impressions
    * User can suggest alternative ingredients and instructions that can be intigrated into the recipe upon approval
    * User can view the user profile of the author to see their other recipies and follow them
### 3. Navigation
**Tab Navigation** (Tab to Screen)

* Focused feed
* Discovery feed
* Profile

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Focused and discovery feed -> recipe page -> view author profile page
* Profile -> evaluate user suggestions and edit profile
* Feeds or Profile -> create new recipe
* Settings -> Toggle settings

## Wireframes
<img src="https://github.com/Chef-Excellence2020/Taste-Buds/blob/main/Assets/WireframeA.png" width=800><br>
<img src="https://github.com/Chef-Excellence2020/Taste-Buds/blob/main/Assets/WireframeB.png" width=800><br>

### [BONUS] Interactive Prototype
<img src="https://github.com/Chef-Excellence2020/Taste-Buds/blob/main/Assets/WireframeGIF.gif" width=200>
GIF created with [ezgif](https://ezgif.com/).

## Schema

### Models

### Post
| Property      | Type     | Description     |
| :------------- | :----------: | :-----------: |
|  postId | String   | unique ID for posts   |
|  userId | String   | unique ID for user   |
| Author | Pointer to User | Recipe author ID |
| title | String | title of recipe |
| Image   | File | picture of recipe |
| caption | String | image caption by author |

### Profile
| Property      | Type     | Description     |
| :------------- | :----------: | :-----------: |
|  userId | String   | unique ID for user   |
| profilePicture   | File | profile picture |
| userBio | String | text user bio |
|  postId | String   | unique ID for posts   |
|  userSaves | array   | Post IDs saved by user   |

### Home and Discovery Feeds
| Property      | Type     | Description     |
| :------------- | :----------: | :-----------: |
|  postId | String   | unique ID for posts   |
|  userId | String   | unique ID for user   |
| Author | Pointer to User | Recipe author ID |
| title | String | title of recipe |
| Image   | File | picture of recipe |
| title | String | title of recipe |
| savesCount   | Number | number of saves |
| createdAt   | DateTime | When recipe was created |
| ratingCount | Number | number of ratings on a post |
| ratingScore | Number | rating on a post |

### Recipe page
| Property      | Type     | Description     |
| :------------- | :----------: | :-----------: |
|  postId | String   | unique ID for posts   |
|  userId | String   | unique ID for user   |
| Author | Pointer to User | Recipe author ID |
| title | String | title of recipe |
| Image   | File | picture of recipe |
| title | String | title of recipe |
| profilePicture   | File | profile picture |
| caption | String | image caption by author |
| savesCount   | Number | number of saves |
| createdAt   | DateTime | When recipe was created |
| ratingCount | Number | number of ratings on a post |
| ratingScore | Number | rating on a post |
| Ingredients  | Array | List of strings containing ingredients |
| Directions  | Array | List of strings containing directions |
| updateDate | DateTime | time and date of any most recent updates |

## Networking

### List of network requests by screen

- Log in
    - (Read/GET) Check login credentials

- Sign up
    -  (Create/POST) Create a new user account

- Main feed
    - (Read/GET) Query all posts where current user follows post author

- View recipe
    - (Read/GET) Check saved status of recipe relative to current user
    - (Read/GET) Return average user score
    - (Update/PUT) Add/remove recipe to user's saved recipes
    - (Update/PUT) add to aggregate user score

- Create new recipe
    - (Create/POST) Create a new recipe

- Edit existing recipe
    - (Read/GET) Get current recipe
    -  (Update/PUT) Send suggestion to recipe author

- Profile
    - (Read/GET) Query all posts where user is author
    - (Read/GET) Check followed status of user (if user != current user)
    - (Update/PUT) Add/remove user from user's follow list

- Edit profile
    - (Read/GET) Query logged in user object
    - (Read/GET) Query all posts where user is author
    - (Update/PUT) Update user profile image

## Walkthrough

<img src="https://github.com/Chef-Excellence2020/Taste-Buds/blob/main/Assets/iPhoneDemo.gif" width=200>
GIF created with [Recordit](https://recordit.co/).
