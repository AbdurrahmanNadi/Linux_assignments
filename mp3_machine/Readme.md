# MP3 Machine
### Project Configuration
	* defconfig file is found in configs directory 
  	  and contains the configs generated to build
  	  the image
	* overalys and the post-build script are in 
	  board under `qemu_arm_versatile_mp3_machine`
	* to automate the preparation (moving the overlays
	  and the config files to their positions) use
	  `build_setup.sh` 
	* using `build_setup.sh` with no arguments displays
	  its help
	* after running that script simply go the build tree
	  directory and type make
	* use the `run_qemu_machine.sh` to run the emulator

### Notes
	* I couldn't find a way to load overlays from outside
	  buildroot except by using an external tree (not out
	  of tree build) which means that I have to copy all
	  the required config files and create my package configs
	  which looked like a big hassle so I opted out of it.
	* You can totally not use the `build_setup.sh` if you want

------------------------------------------------------
This is Assignment 4 MP3 machine Qemu Image
[Abdelrahman Nadi Taha](abdurrahman.naddie@gmail.com)
Mechatronics Track - ITI40
