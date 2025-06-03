# UT2k4OnRO
Porting Unreal Tournament 2004 to Red Orchestra: Ostfront 41-45

it like, it works, what else is there to say, batteries not included tho have to compile urself
![image](https://github.com/user-attachments/assets/3c27e3d8-9980-4492-b176-9849f3182d3c)

## Compiling
there's probably a better way to do this, also i've not tested those instructions

1. Install Red Orchestra: Ostfront 41-45 first, you have to own the game on Steam
2. Install the SDK
3. Symlink all folders in Src/ from here to **steamapps/common/Red Orchestra/**
4. Make a folder named **UT2k4OnRO** inside of "Red Orchestra", copy all UT2k4 content here in this newly created folder, remove all .u files in System/
5. Copy OfficialMod.ini and System/ from this repository to the newly created **UT2k4OnRO** folder, if it asks you to overwrite any files hit yes
6. To prepare for compiling, also remove all .u files in **steamapps/common/Red Orchestra/System/**
7. open a command prompt and go to **steamapps/common/Red Orchestra/** folder, do `ucc make` and pray it works, maybe compile it few times. There's like ghosts here you have to attempt to compile multiple times before you can successfully build it
8. If it still doesn't work, feel free to ask me.
