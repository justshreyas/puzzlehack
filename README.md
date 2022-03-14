# puzzlehack

A submission for the Flutter Puzzle Hack 2022.

# What is this?

A fun game that boasts of responsiveness, animations, sound design, and skeuomorphism.
My Flutter Puzzle Hack submission is a simple Sliding Tiles Puzzle that is always solvable. You can choose between three difficulty levels, viz. Easy, Medium, Hard.
Easy is a 3x3 puzzle with small number of scrambles.
Medium is a 4x4 puzzle with moderate number of scrambles.
Hard is a 5x5 puzzle with ample number of scrambles.
Each time, the game starts with scrambling the tiles in the puzzle. As the difficulty increases, you only see the last few scrambles, to up the ante.
The game session also records the total number of moves you make, and the total time spent solving the puzzle.

The submission uses basic flutter animation widgets (AnimatedContainer, AnimatedPadding, AnimatedSwitcher, AnimatedDefaultTextStyle, AnimatedPositioned) to achieve its on-hover and puzzle sliding animations.
The experience is supplemented with a thoughtful selection of music and sound assets to deliver an engaging experience.

## Inspiration
The submission entry was inspired by a birthday gift I had received as a child. You don't have to be Sherlock for you to guess it was a sliding tiles puzzle. I remember playing this game with my younger brother. We would take turns scrambling a solved puzzle and then we timed each other on who was the fastest. The puzzle pieces often came apart, and we would have to put together the tiles in correct order.
If we did not put the tile in the correct order, sometimes, the puzzle would be unsolvable for hours!

## What it does
My Flutter Puzzle Hack submission is a simple Sliding Tiles Puzzle that is always solvable. You can choose between three difficulty levels, viz. Easy, Medium, Hard.
Easy is a 3x3 puzzle with small number of scrambles.
Medium is a 4x4 puzzle with moderate number of scrambles.
Hard is a 5x5 puzzle with ample number of scrambles.

Each time, the game starts with scrambling the tiles in the puzzle. As the difficulty increases, you only see the last few scrambles, to up the ante.

The game session also records the total number of moves you make, and the total time spent solving the puzzle

## How we built it
I started with the puzzle model and logic to solve it. At this point, the dimension was hard-coded to be 3. I added code to interact with the UI component. Then, I actually wrote the UI code based on the State Management API.
Then, I proceeded to refactor and make the dimension an injectable variable.
I added the algorithm to scramble the puzzle at the beginning of each game session.
I proceeded to introduce puzzle level difficulties, and used the scramble iterations and puzzle dimension to determine the difficulty of a game.

## Challenges we ran into
#### Making the puzzle solvable
For the puzzle to be solvable, it needs to start from a solved state and then scrambled, just like the physical version of this game. If the tiles have random positions, the puzzle may be unsolvable. To overcome this, the puzzle always starts with a solved state, and is then scrambled before starting the game session.
#### Audio package has some issues on web
Sometimes, the audio players get corrupted on the web. This happened to me only in release mode, I  never encountered this in the debug version. This could be a caching issue with the site data, as I was pushing continuous updates. But as you can see in the demo video, everything works as expected in debug mode.
#### Mimicking physical model of the game
If we swap tiles randomly, the position of the tiles can change outside the laws of physics. The scrambling looks weird and unnatural if that happens on the UI. Tiles on a real game would never swap places (unless you dropped you game on the floor!)


## Accomplishments that we're proud of
#### Responsiveness
The app uses 3 breakpoints for large, medium and small sized displays. The UI adapts to the changes made to the window size in real time.
#### Animations
The code uses pure Flutter animations in an elegant way. Subtleties like a slight color change on hover, switching between layouts of different orientations or sizes were handled entirely using out-of-the-box Flutter code.
#### Sound Design
The audio clips and game sounds were carefully curated to suit the mood of the actions associated with each audio asset. The puzzle selection music is adds a sense of mystery and anticipation, while the game session music is motivating and also paired with an aptly paced scrambling countdown sound.
Each element has an on-hover and on-clicked sound. The tile makes a different sound when it is clicked. The chime after puzzle completion is just perfect!
#### Skeuomorphism
The sliding puzzle in itself is very reminiscent of the physical version of the game. The way the tiles move when they are clicked, the way they are scrambled, the speed at which they are scrambled; all mimic real life very closely. This makes interactions very intuitive.
#### Graphics and Design
I am proud of my typography and color choice. I designed and exported the icon set from scratch in Figma. 


## What we learned
#### You cannot auto-play media on the first page load on the web
My submission was always an audio visual experience, so naturally, when I encountered this error, I was devastated. This meant I could not play music when my webpage was loaded. After a little thought and a few deep breaths, I decided to add a welcome screen to launch my game flow. Clicking a button provided the necessary interaction from the user's end with the webpage, before I could autoplay media on my next screens. 
#### You will have to make edits to native code
After completing my Flutter code, and hosting it, I realised that there was a white screen on my webpage. StackOverflow helped me solve it. I also realised that I'd have to add a native splash screen till my flutter engine was initialised and could draw the first frame.
#### There's a AnimatedDefaultTextStyle Widget that I had never heard of
I've used this widget to wrap all of my text. This helped me with a smooth change in the font sizes when resizing my window.


## What's next for Sliding Tiles Puzzle Game by justshreyas
- Adding an "about dialog"
- Investigating the audio player corruption issue in release mode
- Pushing the limits of what is already responsive.

# Links
- Link to working Demo : https://justshreyas.github.io/puzzlehack/
- Link to GitHub repository : https://github.com/justshreyas/puzzlehack
- Link to my Flutter Puzzle Hack submission : https://devpost.com/software/sliding-tiles-puzzle-game-by-justshreyas
- Link to Flutter Puzzle Hack Details : https://flutterhack.devpost.com/
- Link to Flutter Docs : https://flutter.dev
- Follow me on Twitter : https://twitter.com/just_shreyas
- Follow me on Instagram : https://instagram.com/justshreyas
