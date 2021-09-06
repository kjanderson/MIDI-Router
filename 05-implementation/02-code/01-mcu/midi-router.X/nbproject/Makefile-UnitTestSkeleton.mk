#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-UnitTestSkeleton.mk)" "nbproject/Makefile-local-UnitTestSkeleton.mk"
include nbproject/Makefile-local-UnitTestSkeleton.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=UnitTestSkeleton
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS
SUB_IMAGE_ADDRESS_COMMAND=--image-address $(SUB_IMAGE_ADDRESS)
else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../usb-bsp/buttons.c ../usb-bsp/leds.c ../usb/usb_device.c ../usb/usb_device_cdc.c ../usb/usb_hal_16bit.c ../usb-app/app_led_usb_status.c ../usb-app/system.c ../usb-app/usb_descriptors.c ../usb-app/usb_events.c ../usb-app/app_device_cdc_to_uart.c ../fpga.c ../fpga_image.c ../hal.c ../app.c ../flash.c ../event-queue.c ../spi-ctrl.c ../merge_outputs.c ../midi_parser.c ../globals.c ../queue.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1832462041/buttons.o ${OBJECTDIR}/_ext/1832462041/leds.o ${OBJECTDIR}/_ext/1360939189/usb_device.o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o ${OBJECTDIR}/_ext/1832463095/system.o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o ${OBJECTDIR}/_ext/1832463095/usb_events.o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o ${OBJECTDIR}/_ext/1472/fpga.o ${OBJECTDIR}/_ext/1472/fpga_image.o ${OBJECTDIR}/_ext/1472/hal.o ${OBJECTDIR}/_ext/1472/app.o ${OBJECTDIR}/_ext/1472/flash.o ${OBJECTDIR}/_ext/1472/event-queue.o ${OBJECTDIR}/_ext/1472/spi-ctrl.o ${OBJECTDIR}/_ext/1472/merge_outputs.o ${OBJECTDIR}/_ext/1472/midi_parser.o ${OBJECTDIR}/_ext/1472/globals.o ${OBJECTDIR}/_ext/1472/queue.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1832462041/buttons.o.d ${OBJECTDIR}/_ext/1832462041/leds.o.d ${OBJECTDIR}/_ext/1360939189/usb_device.o.d ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d ${OBJECTDIR}/_ext/1832463095/system.o.d ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d ${OBJECTDIR}/_ext/1832463095/usb_events.o.d ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d ${OBJECTDIR}/_ext/1472/fpga.o.d ${OBJECTDIR}/_ext/1472/fpga_image.o.d ${OBJECTDIR}/_ext/1472/hal.o.d ${OBJECTDIR}/_ext/1472/app.o.d ${OBJECTDIR}/_ext/1472/flash.o.d ${OBJECTDIR}/_ext/1472/event-queue.o.d ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d ${OBJECTDIR}/_ext/1472/merge_outputs.o.d ${OBJECTDIR}/_ext/1472/midi_parser.o.d ${OBJECTDIR}/_ext/1472/globals.o.d ${OBJECTDIR}/_ext/1472/queue.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1832462041/buttons.o ${OBJECTDIR}/_ext/1832462041/leds.o ${OBJECTDIR}/_ext/1360939189/usb_device.o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o ${OBJECTDIR}/_ext/1832463095/system.o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o ${OBJECTDIR}/_ext/1832463095/usb_events.o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o ${OBJECTDIR}/_ext/1472/fpga.o ${OBJECTDIR}/_ext/1472/fpga_image.o ${OBJECTDIR}/_ext/1472/hal.o ${OBJECTDIR}/_ext/1472/app.o ${OBJECTDIR}/_ext/1472/flash.o ${OBJECTDIR}/_ext/1472/event-queue.o ${OBJECTDIR}/_ext/1472/spi-ctrl.o ${OBJECTDIR}/_ext/1472/merge_outputs.o ${OBJECTDIR}/_ext/1472/midi_parser.o ${OBJECTDIR}/_ext/1472/globals.o ${OBJECTDIR}/_ext/1472/queue.o

# Source Files
SOURCEFILES=../usb-bsp/buttons.c ../usb-bsp/leds.c ../usb/usb_device.c ../usb/usb_device_cdc.c ../usb/usb_hal_16bit.c ../usb-app/app_led_usb_status.c ../usb-app/system.c ../usb-app/usb_descriptors.c ../usb-app/usb_events.c ../usb-app/app_device_cdc_to_uart.c ../fpga.c ../fpga_image.c ../hal.c ../app.c ../flash.c ../event-queue.c ../spi-ctrl.c ../merge_outputs.c ../midi_parser.c ../globals.c ../queue.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-UnitTestSkeleton.mk dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=24FJ128GB204
MP_LINKER_FILE_OPTION=,--script=p24FJ128GB204.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1832462041/buttons.o: ../usb-bsp/buttons.c  .generated_files/flags/UnitTestSkeleton/e3085e4076ca5989cf2a9e9a7dd0534197abb6fa .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/buttons.c  -o ${OBJECTDIR}/_ext/1832462041/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/buttons.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832462041/leds.o: ../usb-bsp/leds.c  .generated_files/flags/UnitTestSkeleton/8c40fd22952cdba2d82137ac87dcffdf2c819b18 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/leds.c  -o ${OBJECTDIR}/_ext/1832462041/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/leds.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device.o: ../usb/usb_device.c  .generated_files/flags/UnitTestSkeleton/81c4557ab3b1b9d34abf789d9d5f9d01cae6f79f .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o: ../usb/usb_device_cdc.c  .generated_files/flags/UnitTestSkeleton/316a022db12c74ebd6801922ccc3252ea645ab81 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device_cdc.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o: ../usb/usb_hal_16bit.c  .generated_files/flags/UnitTestSkeleton/e4bb36cdf9e64a5e8dceba55a8e567b05960de46 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_hal_16bit.c  -o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o: ../usb-app/app_led_usb_status.c  .generated_files/flags/UnitTestSkeleton/54cbfab0ad5f61daf217ab453acd6afab51ac2cc .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_led_usb_status.c  -o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/system.o: ../usb-app/system.c  .generated_files/flags/UnitTestSkeleton/b2824190da2004a49484ed1127c38710fad82d0f .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/system.c  -o ${OBJECTDIR}/_ext/1832463095/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/system.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_descriptors.o: ../usb-app/usb_descriptors.c  .generated_files/flags/UnitTestSkeleton/b0ba7d1cd9b4122dcbf00c6c17bbb501814c93fd .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_descriptors.c  -o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_events.o: ../usb-app/usb_events.c  .generated_files/flags/UnitTestSkeleton/9b282fa5d64fb590455baa3fc76619c385cbaacc .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_events.c  -o ${OBJECTDIR}/_ext/1832463095/usb_events.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_events.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o: ../usb-app/app_device_cdc_to_uart.c  .generated_files/flags/UnitTestSkeleton/9063845ab43ed0633bb816dc57efd5ef203a735f .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_device_cdc_to_uart.c  -o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga.o: ../fpga.c  .generated_files/flags/UnitTestSkeleton/7b0e2c1a23967aeb9f21d9f348c1183d61d95714 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga.c  -o ${OBJECTDIR}/_ext/1472/fpga.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga_image.o: ../fpga_image.c  .generated_files/flags/UnitTestSkeleton/c4be1766c1b56b0daec1f193b1bd7652acd19f21 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga_image.c  -o ${OBJECTDIR}/_ext/1472/fpga_image.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga_image.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/hal.o: ../hal.c  .generated_files/flags/UnitTestSkeleton/990cd099da5d19ca4fd48228417bcf1f7247eab .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal.c  -o ${OBJECTDIR}/_ext/1472/hal.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/hal.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/app.o: ../app.c  .generated_files/flags/UnitTestSkeleton/a27e35881879b04aabb3512b1f2c9455b48cac7e .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../app.c  -o ${OBJECTDIR}/_ext/1472/app.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/app.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/flash.o: ../flash.c  .generated_files/flags/UnitTestSkeleton/d93a45461919871a1833ecd9a7dfbf7408d84c10 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../flash.c  -o ${OBJECTDIR}/_ext/1472/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/flash.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/event-queue.o: ../event-queue.c  .generated_files/flags/UnitTestSkeleton/ab15c9b04a725cdf8d0c44b6a5d36449787a525a .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../event-queue.c  -o ${OBJECTDIR}/_ext/1472/event-queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/event-queue.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/spi-ctrl.o: ../spi-ctrl.c  .generated_files/flags/UnitTestSkeleton/19fd7d46cb1d156135f8f8929c7fae12ccc4ae62 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../spi-ctrl.c  -o ${OBJECTDIR}/_ext/1472/spi-ctrl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/merge_outputs.o: ../merge_outputs.c  .generated_files/flags/UnitTestSkeleton/5e51a44fcf4a251842a190af8e7dd008b4fd1766 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../merge_outputs.c  -o ${OBJECTDIR}/_ext/1472/merge_outputs.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/merge_outputs.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/midi_parser.o: ../midi_parser.c  .generated_files/flags/UnitTestSkeleton/dc10ada6593bd6aa2b405dfcd35c42275c8dceeb .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../midi_parser.c  -o ${OBJECTDIR}/_ext/1472/midi_parser.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/midi_parser.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/globals.o: ../globals.c  .generated_files/flags/UnitTestSkeleton/f94c0d051071fd42ff4734830e7090281e456202 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../globals.c  -o ${OBJECTDIR}/_ext/1472/globals.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/globals.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/queue.o: ../queue.c  .generated_files/flags/UnitTestSkeleton/79b516f083a869c784001d2cebeddb0781e0ccf5 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../queue.c  -o ${OBJECTDIR}/_ext/1472/queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/queue.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1832462041/buttons.o: ../usb-bsp/buttons.c  .generated_files/flags/UnitTestSkeleton/72dcb112dcd6b53959a60f8d319a9ba78d24195 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/buttons.c  -o ${OBJECTDIR}/_ext/1832462041/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/buttons.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832462041/leds.o: ../usb-bsp/leds.c  .generated_files/flags/UnitTestSkeleton/7178d5d203c1204948083fda4283e070a677370f .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/leds.c  -o ${OBJECTDIR}/_ext/1832462041/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/leds.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device.o: ../usb/usb_device.c  .generated_files/flags/UnitTestSkeleton/7a374dc7756dbde25312afb5a814243954a6c4d5 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o: ../usb/usb_device_cdc.c  .generated_files/flags/UnitTestSkeleton/fe029b1c8e7e7d3c1cfcc94734d78a44743608a0 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device_cdc.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o: ../usb/usb_hal_16bit.c  .generated_files/flags/UnitTestSkeleton/8d7efbf99931dc4326a368f11146b4a4d0e044c4 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_hal_16bit.c  -o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o: ../usb-app/app_led_usb_status.c  .generated_files/flags/UnitTestSkeleton/cc40ad2450cea41630fdd8aba4930c64b224073f .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_led_usb_status.c  -o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/system.o: ../usb-app/system.c  .generated_files/flags/UnitTestSkeleton/e99c2fadc7a83c50de4b141d6720499d581b48e7 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/system.c  -o ${OBJECTDIR}/_ext/1832463095/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_descriptors.o: ../usb-app/usb_descriptors.c  .generated_files/flags/UnitTestSkeleton/c3cd2a01a283d36af6d52d9353860669b29dce2c .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_descriptors.c  -o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_events.o: ../usb-app/usb_events.c  .generated_files/flags/UnitTestSkeleton/eca3d9edf53059bf86ce587e46c5e316bb0b5e5b .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_events.c  -o ${OBJECTDIR}/_ext/1832463095/usb_events.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_events.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o: ../usb-app/app_device_cdc_to_uart.c  .generated_files/flags/UnitTestSkeleton/897037b31f4a940054db39c732e00a8995325c94 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_device_cdc_to_uart.c  -o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga.o: ../fpga.c  .generated_files/flags/UnitTestSkeleton/ca9df1e754c0ef5ba9160244e04804205f36feec .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga.c  -o ${OBJECTDIR}/_ext/1472/fpga.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga_image.o: ../fpga_image.c  .generated_files/flags/UnitTestSkeleton/1e33cbfbd4dfe665d2d8d54037c215caabe734d6 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga_image.c  -o ${OBJECTDIR}/_ext/1472/fpga_image.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga_image.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/hal.o: ../hal.c  .generated_files/flags/UnitTestSkeleton/eb33bfec4e0e67939a034baa180763a5d43e69c8 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal.c  -o ${OBJECTDIR}/_ext/1472/hal.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/hal.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/app.o: ../app.c  .generated_files/flags/UnitTestSkeleton/affaea64ed0ddcf9b561a27a5fbb557d05bd0df1 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../app.c  -o ${OBJECTDIR}/_ext/1472/app.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/app.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/flash.o: ../flash.c  .generated_files/flags/UnitTestSkeleton/9e30dbdc9c54a33092a40205a19257695786fed9 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../flash.c  -o ${OBJECTDIR}/_ext/1472/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/flash.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/event-queue.o: ../event-queue.c  .generated_files/flags/UnitTestSkeleton/a5f049bc1df6ca9c07f3e02bd3a7ed4863682f20 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../event-queue.c  -o ${OBJECTDIR}/_ext/1472/event-queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/event-queue.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/spi-ctrl.o: ../spi-ctrl.c  .generated_files/flags/UnitTestSkeleton/8405792b9f3deffa3d6d4075bd747510b3b72fa6 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../spi-ctrl.c  -o ${OBJECTDIR}/_ext/1472/spi-ctrl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/merge_outputs.o: ../merge_outputs.c  .generated_files/flags/UnitTestSkeleton/218810686ecdb2284f4f79c9d370c6d2408a2b4 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../merge_outputs.c  -o ${OBJECTDIR}/_ext/1472/merge_outputs.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/merge_outputs.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/midi_parser.o: ../midi_parser.c  .generated_files/flags/UnitTestSkeleton/f67fa5215e27c163bead31abd13de2f977a00502 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../midi_parser.c  -o ${OBJECTDIR}/_ext/1472/midi_parser.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/midi_parser.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/globals.o: ../globals.c  .generated_files/flags/UnitTestSkeleton/c08a0ca14b7ac276cf7e867aee4b26491d655eb4 .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../globals.c  -o ${OBJECTDIR}/_ext/1472/globals.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/globals.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/queue.o: ../queue.c  .generated_files/flags/UnitTestSkeleton/f24d9c871509734007c058af575778c425f8e23b .generated_files/flags/UnitTestSkeleton/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../queue.c  -o ${OBJECTDIR}/_ext/1472/queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/queue.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)      -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_UnitTestSkeleton=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/UnitTestSkeleton
	${RM} -r dist/UnitTestSkeleton

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
