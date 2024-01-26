# ts-quiz

  I started creating this app as my first iOS development personal project while being a completely beginner - around 10 days into learning Swift and UIKit. Inspired by my love for Taylor Swift's music, it began as a simple quiz app but grew as I was studying and learning. As I was developing it, I continually added some features and refactored code to improve my skills, migrating from MVC to MVVM, for example. 

  It reflects my journey from a novice to a little bit more experienced developer and combines my passion for music with my growing proficiency in iOS development. That being said, this project showcases my dedication to learning and demonstrates that with persistence, you can turn creative ideas into functional apps.

<img src="https://github.com/guilhermebrv/ts-quiz/assets/104163003/041fc826-7150-4f1f-8c76-de4472ac5380" width="180" height="400" />
<img src="https://github.com/guilhermebrv/ts-quiz/assets/104163003/8aa96808-076e-45f0-bfa3-66fd0c40f275" width="180" height="400" />
<img src="https://github.com/guilhermebrv/ts-quiz/assets/104163003/6ca6d5aa-9fe9-432c-aee4-42f3ba667926" width="180" height="400" />
<img src="https://github.com/guilhermebrv/ts-quiz/assets/104163003/f5c33e99-3fdf-4bf2-b220-62fc70323ede" width="180" height="400" />
<img src="https://github.com/guilhermebrv/ts-quiz/assets/104163003/1a2483f1-3731-438f-83ed-e332a99de971" width="180" height="400" />

## Key Features

- **MVVM Architecture**

- **API Communication and Service Layer:** Created a simulated JSON API from where I would get the retrieval of questions. In a separate file for API interactions, used URLSession for the network request, in order to maintain modularity and separation of responsibilities.

- **Core Data Integration:**  Singleton pattern for centralized user data management, and incorporated a mechanism to reset stored data upon the start of a new game session, handling scenarios where the app is closed prematurely or terminated by the system to prevent unused data to be saved.

- **Database Integration:** User details are saved from Core Data to a MongoDB database on the final score screen.

- **Dynamic Content and Logic:** Created a method to fetch from the API questions based on the difficulty selected and randomize them, ensuring a varied experience for the user at each play.

- **Gameplay Customization:** Enabled players to choose quiz difficulty and their favorite Taylor Swift era, influencing the questions and UI theme.

- **Leaderboard Implementation:** Built a leaderboard screen using UITableView to display player details and rankings received from the database.

## How to Use

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/guilhermebrv/ts-quiz.git

2. **Open in Xcode:**
- Launch the project in Xcode and run it on your preferred iOS simulator or device.

3. **Explore the App:**
- Enter your details, optionally choose a photo, select your favorite era, and set the game difficulty. Get ready to play!
- Check how well you rank on the leaderboard compared to other players.
