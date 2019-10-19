#include "myLib.h"
// TODO 1.0: Include your .h files here.
#include "bg.h"
#include "spritesheet.h"



void initialize();

unsigned short buttons;
unsigned short oldButtons;

int hOff = 0;
int vOff = 0;

OBJ_ATTR shadowOAM[128];

typedef struct {
	int row;
	int col;
    int rdel;
    int cdel;
	int width;
    int height;
    int aniCounter;
    int aniState;
    int prevAniState;
    int curFrame;
    int numFrames;
} ANISPRITE;

ANISPRITE pikachu;

// States used for pikachu.aniState
// Idle does not have an actual image associated with it;
// Whenever pikachu is idle, just show whatever state pikachu was before (prevAniState)
enum { PIKAFRONT, PIKABACK, PIKARIGHT, PIKALEFT, PIKAIDLE};

int main() {

    initialize(); 

	int buttonPushed;

	while(1) {

        // TODO 2.1: Set previous state to current state (if not idle)
		//           then reset pikachu's state to idle
		// NOTE: We reset pikachu's state to idle at the beginning of every
		//       frame so that we can easily check to see if any button was pressed.
		// Look for the TODO past the button input section for more explanation, but don't complete it yet
		if (!(pikachu.aniState == PIKAIDLE)) {
			pikachu.prevAniState = pikachu.aniState;
			pikachu.aniState = PIKAIDLE;
		}



        // Change the animation frame every 20 frames of gameplay
		if(pikachu.aniCounter % 20 == 0) {
			// TODO 2.2: Change the frame here
			//           Remember that there are only numFrames number of frames
			pikachu.curFrame = ((pikachu.curFrame == 2) ? 0 : pikachu.curFrame + 1);
		}
		
		buttonPushed = 0;

        // Control movement and change animation state
		if(BUTTON_HELD(BUTTON_UP)) {
			// TODO 2.3: Set pikachu's aniState here accordingly
			pikachu.aniState = PIKABACK;
			vOff--;
			buttonPushed = 1;
		}
		if(BUTTON_HELD(BUTTON_DOWN)) {
			// TODO 2.4: Set pikachu's aniState here accordingly
			pikachu.aniState = PIKAFRONT;
			vOff++;
			buttonPushed = 1;
		}
		if(BUTTON_HELD(BUTTON_LEFT)) {
			// TODO 2.5: Set pikachu's aniState here accordingly
			pikachu.aniState = PIKALEFT;
			hOff--;
			buttonPushed = 1;
		}
		if(BUTTON_HELD(BUTTON_RIGHT)) {
			// TODO 2.6: Set pikachu's aniState here accordingly 
			pikachu.aniState = PIKARIGHT;
			hOff++;
			buttonPushed = 1;
		}

		// TODO 2.7: If the pikachu aniState is idle (thus no key is held), 
		//           we want the frame to be pikachu standing (frame 0)
		//           in whatever direction pikachu was facing (set aniState to prevAniState)
        //           Else, if pikachu aniState is not idle, we want to increment aniCounter
		if (buttonPushed == 0) {
			pikachu.curFrame = 0;
			pikachu.aniState = pikachu.prevAniState;
		} else {
			pikachu.aniCounter++;
		}

        // TODO 2.8: Using the proper flags from myLib.h, set up all of your sprite attributes.
        //           (seriously, go look in myLib.h for sprite stuff)
        //           Remember, you will want to consider your current frame and animation state
        //           when telling attr2 which tile index to find the image at.
        //           Hint: frames are the rows of the spritesheet, and animation states are the columns
        //           Hint: since this sprite is 16x16, you are going to have to do some multiplication...
        //           When pikachu is idle (the aniState PIKAIDLE), the frame should be 0
		shadowOAM[0].attr0 = pikachu.row;
		shadowOAM[0].attr1 = pikachu.col | ATTR1_SMALL;
		shadowOAM[0].attr2 = (ATTR2_TILEID((pikachu.aniState*2), pikachu.curFrame * 2) | ATTR2_PALROW(0) | ATTR2_PRIORITY(0));

		waitForVBlank();

        // TODO 2.9: Copy the shadowOAM into the OAM
		DMANow(3, shadowOAM, OAM, (((sizeof(shadowOAM))/4) | DMA_DESTINATION_INCREMENT | DMA_SOURCE_INCREMENT | DMA_32));




        REG_BG0HOFF = hOff;
        REG_BG0VOFF = vOff;
	}

	return 0;
}


void initialize() {

    // Load the background's palette and tiles into a desired space in memory
    DMANow(3, bgPal, PALETTE, 256);
    DMANow(3, bgTiles, &CHARBLOCK[0], bgTilesLen / 2);
    DMANow(3, bgMap, &SCREENBLOCK[28], 1024 * 4);

    // Tell the BG0 control register where to look for its tiles and tile map AND
    // 		how to read them from this location (using the given settings)
    REG_BG0CNT = BG_CHARBLOCK(0) | BG_SCREENBLOCK(28) | BG_4BPP | BG_SIZE_LARGE;
    
    // TODO 1.2: Load the spritesheet Tiles and Pal into THEIR desired spaces in memory
    // (Sprite Palette and Background Palette are 2 different things)
	DMANow(3, spritesheetTiles, &CHARBLOCK[4], spritesheetTilesLen/2);
	DMANow(3, spritesheetPal, SPRITEPALETTE, 256);

    // TODO 1.3: Hide all sprites with hideSprites().  You must complete this function yourself in myLib.c.
    hideSprites();
    
    REG_DISPCTL = MODE0 | BG0_ENABLE | SPRITE_ENABLE; // TODO 3.3: Enable Sprites here    

    pikachu.width = 16;
    pikachu.height = 16;
    pikachu.cdel = 1;
    pikachu.rdel = 1;
	pikachu.col = SCREENWIDTH/2-pikachu.height/2;
	pikachu.row = SCREENHEIGHT/2-pikachu.width/2;

	// TODO 2.0: Just read this (carefully).  No code needs to be edited here.
	/*	=== Animation Variables ===
	*	aniCounter: Used to count how many frames have passed
	*	curFrame: which frame of animation pikachu is in (row in spritesheet)
    *   numFrames: the total number of frames
	*	aniState: which state of animation pikachu is in (column in spritesheet)
	*/
	pikachu.aniCounter = 0;
    pikachu.curFrame = 0;
    pikachu.numFrames = 3;

	pikachu.aniState = PIKAFRONT; 

    buttons = BUTTONS;
    
    // Because why not start here?
	hOff = 0;
	vOff = 100;

}