#include "eadk_vars.h"
#include "eadk.h"

const char eadk_app_name[] __attribute__((section(".rodata.eadk_app_name"))) = "DOOM";
const uint32_t eadk_api_level __attribute__((section(".rodata.eadk_api_level"))) = 0;
