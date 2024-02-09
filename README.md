# yorick-antilag made for ox_inventory

## ox_inventory item
```lua
    ['pop_tune'] = {
        label = 'Tune to spit flames',
        weight = 1000,
        stack = false,
        close = true,
        description = 'Pop tune for every vehicle.',
        client = {
            export = 'yorick-antilag.AntiLagCheck'
        }
    },
```
# Below is the image right click it and save file as `pop_tune`

![pop_tune](https://github.com/TheStoicBear/yorick-antilag/assets/112611821/326346a7-3ebb-4067-8f2e-3652ce821fe8)


This script enables antilag and "twostep" functionality in your FiveM server. <br>
There is a file `config.lua` which you can use to add new cars to the config or to modify existing values!

# Configuration

In addition to enabling antilag, you can also configure the following options:

- explosionSpeed: The speed at which the explosion is created. Default value is 250. <br>
- flameSize: The size of the flames. Default is 1.5. <br>
- RPM: The amount of RPM needed until the antilag is triggered. <br>

# Commands 

- No more commands, as it is handled by a item now.
- If player has item `pop_tune` you can use this to do the same as the command before without providing cars in the configuration file.

# Custom audio
- The script uses custom audio files that are played using NUI.

# Usage

To use antilag in your FiveM server, simply start the yorick-antilag resource, `ensure yorick-antilag`. By default, the antilag effect is triggered when the driver of the vehicle releases the W key when the car reaches a specific amount of RPM.
