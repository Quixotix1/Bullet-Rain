Josh Geelen 100968153
# Bullet Rain
A little project made for the purposes of optimization testing Godot. The game is a simple touhou-based bullet hell where a series of bullets fall down at the player in waves. WASD or arrow keys to move and left-shift or 'c' to slow down.

Naturally, as it is a bullet hell, spawning a lot of objects reduced the FPS significantly. Furthermore, in this game specifically, a bullet is essentially being spawned every frame. From 240 FPS initially, the framerate would drop all the way down to 30-40 FPS after around 10000 frames (a couple minutes total).

The implemented pattern was an object pool for two reasons: firstly, I wanted to improve on my previous implementation of object pooling to see if it made a difference, and secondly, I want to see if object pooling actually makes a tangible difference in Godot. One of my predictions is that Godot's spawning is efficient enough that an object pool may simply not make enough of an optimization difference to be relevant. The implementation in the main branch is simple instantiation and dequeing of each bullet, while the pooled-objects branch restructures bullet spawning around a BulletPool singleton.

A live demo of both versions running with the profiler open is available at the link: https://youtu.be/iWKL-Wd3VmE

After 10000 frames, the pooled objects branch runs at around 20-30 FPS with worse frame times, meaning the experiment was, again, a failure. I have a few guesses as to why this is. Firstly, as I previously predicted, I believe the cost of rendering exceeds the cost of instantiating and adding to the scene tree, especially with the deep post-processing effects in this game. Secondly, the object pool and enemy script are still likely suboptimal relative to a perfect implementation. I believe there are a lot of unnecessary calculations that make it excessively difficult for processing.

As an aside, the project would grind to a halt if I attempted to instantiate more than 3000 objects during initialization. I'm actually not sure why, as the performance would remain relatively stable up to 3000 and rapidly deteriorate after that. I initially wanted 50000 objects as I believed there would eventually be that many on screen, but the project simply wouldn't load/frame times would exceed minutes.

In summary, the profiling process (fully played out below) revealed again that object pooling does not seem to grant a significant performance boost in Godot. I would like to attempt to make an object pool once again using a DLL before I can ultimately draw a conclusion.

All Source Files for your project including code and assets. If your project requires any special instructions to open in an editor, include these in your readme file.
A Release containing a downloadable Windows or Web build of your project (don't rely on a build folder within your repository,)
