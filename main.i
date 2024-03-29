# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 1 "myLib.h" 1




typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
# 64 "myLib.h"
extern unsigned short *videoBuffer;
# 85 "myLib.h"
typedef struct {
 u16 tileimg[8192];
} charblock;


typedef struct {
 u16 tilemap[1024];
} screenblock;



void setPixel3(int col, int row, unsigned short color);
void drawRect3(int col, int row, int width, int height, volatile unsigned short color);
void fillScreen3(volatile unsigned short color);
void drawImage3(int col, int row, int width, int height, const unsigned short *image);
void drawFullscreenImage3(const unsigned short *image);


void setPixel4(int col, int row, unsigned char colorIndex);
void drawRect4(int col, int row, int width, int height, volatile unsigned char colorIndex);
void fillScreen4(volatile unsigned char colorIndex);
void drawImage4(int col, int row, int width, int height, const unsigned short *image);
void drawFullscreenImage4(const unsigned short *image);


void waitForVBlank();
void flipPage();





typedef struct {
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
} OBJ_ATTR;



extern OBJ_ATTR shadowOAM[];
# 157 "myLib.h"
void hideSprites();
# 178 "myLib.h"
extern unsigned short oldButtons;
extern unsigned short buttons;
# 189 "myLib.h"
typedef volatile struct {
    volatile const void *src;
    volatile void *dst;
    volatile unsigned int cnt;
} DMA;


extern DMA *dma;
# 229 "myLib.h"
void DMANow(int channel, volatile const void *src, volatile void *dst, unsigned int cnt);




int collision(int colA, int rowA, int widthA, int heightA, int colB, int rowB, int widthB, int heightB);
# 2 "main.c" 2

# 1 "bg.h" 1
# 22 "bg.h"
extern const unsigned short bgTiles[4848];


extern const unsigned short bgMap[4096];


extern const unsigned short bgPal[256];
# 4 "main.c" 2
# 1 "spritesheet.h" 1
# 21 "spritesheet.h"
extern const unsigned short spritesheetTiles[16384];


extern const unsigned short spritesheetPal[256];
# 5 "main.c" 2



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




enum { PIKAFRONT, PIKABACK, PIKARIGHT, PIKALEFT, PIKAIDLE};

int main() {

    initialize();

 int buttonPushed;

 while(1) {






  if (!(pikachu.aniState == PIKAIDLE)) {
   pikachu.prevAniState = pikachu.aniState;
   pikachu.aniState = PIKAIDLE;
  }




  if(pikachu.aniCounter % 20 == 0) {


   pikachu.curFrame = ((pikachu.curFrame == 2) ? 0 : pikachu.curFrame + 1);
  }

  buttonPushed = 0;


  if((~((*(volatile unsigned short *)0x04000130)) & ((1<<6)))) {

   pikachu.aniState = PIKABACK;
   vOff--;
   buttonPushed = 1;
  }
  if((~((*(volatile unsigned short *)0x04000130)) & ((1<<7)))) {

   pikachu.aniState = PIKAFRONT;
   vOff++;
   buttonPushed = 1;
  }
  if((~((*(volatile unsigned short *)0x04000130)) & ((1<<5)))) {

   pikachu.aniState = PIKALEFT;
   hOff--;
   buttonPushed = 1;
  }
  if((~((*(volatile unsigned short *)0x04000130)) & ((1<<4)))) {

   pikachu.aniState = PIKARIGHT;
   hOff++;
   buttonPushed = 1;
  }





  if (buttonPushed == 0) {
   pikachu.curFrame = 0;
   pikachu.aniState = pikachu.prevAniState;
  } else {
   pikachu.aniCounter++;
  }
# 112 "main.c"
  shadowOAM[0].attr0 = pikachu.row;
  shadowOAM[0].attr1 = pikachu.col | (1<<14);
  shadowOAM[0].attr2 = (((pikachu.curFrame * 2)*32+((pikachu.aniState*2))) | ((0)<<12) | ((0)<<10));

  waitForVBlank();


  DMANow(3, shadowOAM, ((OBJ_ATTR*)(0x7000000)), (((sizeof(shadowOAM))/4) | (0 << 21) | (0 << 23) | (1 << 26)));




        (*(volatile unsigned short *)0x04000010) = hOff;
        (*(volatile unsigned short *)0x04000012) = vOff;
 }

 return 0;
}


void initialize() {


    DMANow(3, bgPal, ((unsigned short *)0x5000000), 256);
    DMANow(3, bgTiles, &((charblock *)0x6000000)[0], 9696 / 2);
    DMANow(3, bgMap, &((screenblock *)0x6000000)[28], 1024 * 4);



    (*(volatile unsigned short*)0x4000008) = ((0)<<2) | ((28)<<8) | (0<<7) | (3<<14);



 DMANow(3, spritesheetTiles, &((charblock *)0x6000000)[4], 32768/2);
 DMANow(3, spritesheetPal, ((unsigned short *)0x5000200), 256);


    hideSprites();

    (*(unsigned short *)0x4000000) = 0 | (1<<8) | (1<<12);

    pikachu.width = 16;
    pikachu.height = 16;
    pikachu.cdel = 1;
    pikachu.rdel = 1;
 pikachu.col = 240/2-pikachu.height/2;
 pikachu.row = 160/2-pikachu.width/2;
# 167 "main.c"
 pikachu.aniCounter = 0;
    pikachu.curFrame = 0;
    pikachu.numFrames = 3;

 pikachu.aniState = PIKAFRONT;

    buttons = (*(volatile unsigned short *)0x04000130);


 hOff = 0;
 vOff = 100;

}
