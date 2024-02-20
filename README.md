# "Cosmic Laser Clash" a small game made in the course of learning. It is developed using the SpriteKit framework and written in the Swift programming language.

### Technologies Used:
- Swift Programming Language.
- SpriteKit Framework. 
- AVFoundation Framework.
- Timers.

### Skills Acquired:
- SpriteKit Development: Knowledge and skills related to SpriteKit for creating 2D games on iOS. Various SpriteKit nodes are used, such as SKSpriteNode for displaying images, SKEmitterNode for particle effects (e.g., starfield, explosions), and SKLabelNode for displaying text.
- Physics Simulation: Understanding of physics in game development, including collision detection and handling. Physics simulation is set up using SKPhysicsWorld to handle collisions and interactions between game objects.
- User Interaction: The game responds to user touch events (touchesBegan, touchesEnded) for shooting lasers, handling UFO taps, and restarting the game.
- Audio Integration: Integration of audio elements into a game using the AVFoundation framework. The game used the SoundManager Class, which contains a static shared property that represents a single instance of the SoundManager class. The static shared method returns this instance or creates it if it has not been created yet. Thus, there is only one Sound Manager object in the application to manage sound effects, which corresponds to the singleton pattern.
- Timed Events: Use of timers to schedule and manage events at specific intervals. The game utilizes timers (via Timer class) for creating UFOs at specific intervals and managing the game's countdown timer.
