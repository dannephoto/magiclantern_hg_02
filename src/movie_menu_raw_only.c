/** \file
 * Reorganise Movie menu for RAW/h264 recording modes
 */
#include "dryos.h"
#include "math.h"
#include "version.h"
#include "bmp.h"
#include "gui.h"
#include "config.h"
#include "property.h"
#include "lens.h"
#include "font.h"
#include "menu.h"
#include "beep.h"
#include "zebra.h"
#include "focus.h"
#include "menuhelp.h"
#include "console.h"
#include "debug.h"
#include "lvinfo.h"
#include "powersave.h"

// Explicitly define the order of the Movie menu
// Also decides where entries from modules will end up
static struct menu_entry movie_menu_raw_toggle[] =
{
    {
         .name = "Crop mood",
         .placeholder = 1,
    },
    {
         .name = "RAW video",
         .placeholder = 1,
    },
    {
         .name = "Bit-depth",
         .placeholder = 1,
    },
    {
         .name = "Framerate:",
         .placeholder = 1,
    },
    {
         .name = "Aspect ratio:",
         .placeholder = 1,
    },
    {
         .name = "Customize buttons",
         .placeholder = 1,
    },
    {
        .name = "Custom modes",
        .placeholder = 1,
    },
    {
        .name = "Sound recording",
        .placeholder = 1,
    },
    {
        .name = "Shutter Expo",
        .placeholder = 1,
    },
    {
        .name = "Aperture Expo",
        .placeholder = 1,
    },
    {
        .name = "ISO Expo",
        .placeholder = 1,
    },
    {
        .name = "Shutter lock",
        .placeholder = 1,
    },
    {
        .name = "Shutter fine-tuning",
        .placeholder = 1,
    },
    {
        .name = "Shutter range",
        .placeholder = 1,
    },
    {
        .name = "SD Overclock",
        .placeholder = 1,
    },
    {
        .name = "HDR video",
        .placeholder = 1,
    },
    {
        .name = "FPS override",
        .placeholder = 1,
    },
    {
        .name = "FPS modifier",
        .placeholder = 1,
    },
    {
        .name = "intervalometer",
        .placeholder = 1,
    },
    {
        .name = "recording delay",
        .placeholder = 1,
    },
    /*
    {
        .name = "presets",
        .placeholder = 1,
    },
    {
        .name = "raw video",
        .placeholder = 1,
    },
    {
        .name = "ratio",
        .placeholder = 1,
    },
    {
        .name = "bitdepth",
        .placeholder = 1,
    },
    {
        .name = "set 25fps",
        .placeholder = 1,
    },
    {
        .name = "white balance",
        .placeholder = 1,
    },
     */
};

static void movie_menu_raw_only_init()
{
    menu_add( "Movie", movie_menu_raw_toggle, COUNT(movie_menu_raw_toggle) );
}

INIT_FUNC(__FILE__, movie_menu_raw_only_init);
