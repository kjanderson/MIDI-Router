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
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
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
SOURCEFILES_QUOTED_IF_SPACED=../usb-bsp/buttons.c ../usb-bsp/leds.c ../usb/usb_device.c ../usb/usb_device_cdc.c ../usb/usb_hal_16bit.c ../usb-app/app_led_usb_status.c ../usb-app/system.c ../usb-app/usb_descriptors.c ../usb-app/usb_events.c ../usb-app/app_device_cdc_to_uart.c ../fpga.c ../fpga_image.c ../hal.c ../main.c ../app.c ../flash.c ../event-queue.c ../spi-ctrl.c ../merge_outputs.c ../midi_parser.c ../globals.c ../queue.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1832462041/buttons.o ${OBJECTDIR}/_ext/1832462041/leds.o ${OBJECTDIR}/_ext/1360939189/usb_device.o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o ${OBJECTDIR}/_ext/1832463095/system.o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o ${OBJECTDIR}/_ext/1832463095/usb_events.o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o ${OBJECTDIR}/_ext/1472/fpga.o ${OBJECTDIR}/_ext/1472/fpga_image.o ${OBJECTDIR}/_ext/1472/hal.o ${OBJECTDIR}/_ext/1472/main.o ${OBJECTDIR}/_ext/1472/app.o ${OBJECTDIR}/_ext/1472/flash.o ${OBJECTDIR}/_ext/1472/event-queue.o ${OBJECTDIR}/_ext/1472/spi-ctrl.o ${OBJECTDIR}/_ext/1472/merge_outputs.o ${OBJECTDIR}/_ext/1472/midi_parser.o ${OBJECTDIR}/_ext/1472/globals.o ${OBJECTDIR}/_ext/1472/queue.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1832462041/buttons.o.d ${OBJECTDIR}/_ext/1832462041/leds.o.d ${OBJECTDIR}/_ext/1360939189/usb_device.o.d ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d ${OBJECTDIR}/_ext/1832463095/system.o.d ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d ${OBJECTDIR}/_ext/1832463095/usb_events.o.d ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d ${OBJECTDIR}/_ext/1472/fpga.o.d ${OBJECTDIR}/_ext/1472/fpga_image.o.d ${OBJECTDIR}/_ext/1472/hal.o.d ${OBJECTDIR}/_ext/1472/main.o.d ${OBJECTDIR}/_ext/1472/app.o.d ${OBJECTDIR}/_ext/1472/flash.o.d ${OBJECTDIR}/_ext/1472/event-queue.o.d ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d ${OBJECTDIR}/_ext/1472/merge_outputs.o.d ${OBJECTDIR}/_ext/1472/midi_parser.o.d ${OBJECTDIR}/_ext/1472/globals.o.d ${OBJECTDIR}/_ext/1472/queue.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1832462041/buttons.o ${OBJECTDIR}/_ext/1832462041/leds.o ${OBJECTDIR}/_ext/1360939189/usb_device.o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o ${OBJECTDIR}/_ext/1832463095/system.o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o ${OBJECTDIR}/_ext/1832463095/usb_events.o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o ${OBJECTDIR}/_ext/1472/fpga.o ${OBJECTDIR}/_ext/1472/fpga_image.o ${OBJECTDIR}/_ext/1472/hal.o ${OBJECTDIR}/_ext/1472/main.o ${OBJECTDIR}/_ext/1472/app.o ${OBJECTDIR}/_ext/1472/flash.o ${OBJECTDIR}/_ext/1472/event-queue.o ${OBJECTDIR}/_ext/1472/spi-ctrl.o ${OBJECTDIR}/_ext/1472/merge_outputs.o ${OBJECTDIR}/_ext/1472/midi_parser.o ${OBJECTDIR}/_ext/1472/globals.o ${OBJECTDIR}/_ext/1472/queue.o

# Source Files
SOURCEFILES=../usb-bsp/buttons.c ../usb-bsp/leds.c ../usb/usb_device.c ../usb/usb_device_cdc.c ../usb/usb_hal_16bit.c ../usb-app/app_led_usb_status.c ../usb-app/system.c ../usb-app/usb_descriptors.c ../usb-app/usb_events.c ../usb-app/app_device_cdc_to_uart.c ../fpga.c ../fpga_image.c ../hal.c ../main.c ../app.c ../flash.c ../event-queue.c ../spi-ctrl.c ../merge_outputs.c ../midi_parser.c ../globals.c ../queue.c



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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=24FJ128GB204
MP_LINKER_FILE_OPTION=,--script=p24FJ128GB204.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1832462041/buttons.o: ../usb-bsp/buttons.c  .generated_files/flags/default/78f6875780a31bb760e7582200f120c7cdc8d6a1 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/buttons.c  -o ${OBJECTDIR}/_ext/1832462041/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/buttons.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832462041/leds.o: ../usb-bsp/leds.c  .generated_files/flags/default/5eb9ae4c18409ea513e204e7e0fb02120480704f .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/leds.c  -o ${OBJECTDIR}/_ext/1832462041/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/leds.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device.o: ../usb/usb_device.c  .generated_files/flags/default/2eeb8efe0a5fb6cfaf1ede60bafc72f2aab8815b .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o: ../usb/usb_device_cdc.c  .generated_files/flags/default/7d8dad1d5be9a01f83e8704f6cf1fdf7bc268a5e .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device_cdc.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o: ../usb/usb_hal_16bit.c  .generated_files/flags/default/4a6f1c1ac6449777f175c563c9f1771d7364da6f .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_hal_16bit.c  -o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o: ../usb-app/app_led_usb_status.c  .generated_files/flags/default/285c88d1cc1ca67165246d4dd559c4839d799aae .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_led_usb_status.c  -o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/system.o: ../usb-app/system.c  .generated_files/flags/default/1b329b5d6d6d9a6afdce2110146d91170af3d521 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/system.c  -o ${OBJECTDIR}/_ext/1832463095/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/system.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_descriptors.o: ../usb-app/usb_descriptors.c  .generated_files/flags/default/77b2874bc6b70b57b60cb325fcbb070aeccc1a2a .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_descriptors.c  -o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_events.o: ../usb-app/usb_events.c  .generated_files/flags/default/a28c2409555f8a1f05b47bd56c95407a6218d662 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_events.c  -o ${OBJECTDIR}/_ext/1832463095/usb_events.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_events.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o: ../usb-app/app_device_cdc_to_uart.c  .generated_files/flags/default/765f6d65e8704d10fdc7afb667bca44b27c81ee6 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_device_cdc_to_uart.c  -o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga.o: ../fpga.c  .generated_files/flags/default/f086436f1eacc82809095e0d06010147d3df3a8a .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga.c  -o ${OBJECTDIR}/_ext/1472/fpga.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga_image.o: ../fpga_image.c  .generated_files/flags/default/e47fc65f9a9becc4ca9fcaf50194bbebd4c1917f .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga_image.c  -o ${OBJECTDIR}/_ext/1472/fpga_image.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga_image.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/hal.o: ../hal.c  .generated_files/flags/default/9366ba8a2b7ea401575266cbb2f56978c1c3bda5 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal.c  -o ${OBJECTDIR}/_ext/1472/hal.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/hal.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  .generated_files/flags/default/790cde52b1ecf314adbb301ab54638afd2d256bc .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../main.c  -o ${OBJECTDIR}/_ext/1472/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/app.o: ../app.c  .generated_files/flags/default/2e8a32943d2f8aadd94d7e8c276aad7e0df691da .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../app.c  -o ${OBJECTDIR}/_ext/1472/app.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/app.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/flash.o: ../flash.c  .generated_files/flags/default/d3ce7c016bb61fcd837515a8780a172404b4062e .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../flash.c  -o ${OBJECTDIR}/_ext/1472/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/flash.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/event-queue.o: ../event-queue.c  .generated_files/flags/default/692a3630ca42032b5600974d1e14da459312725 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../event-queue.c  -o ${OBJECTDIR}/_ext/1472/event-queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/event-queue.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/spi-ctrl.o: ../spi-ctrl.c  .generated_files/flags/default/6f32864d1ef3831f288b48fd2767d1ad9855b55e .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../spi-ctrl.c  -o ${OBJECTDIR}/_ext/1472/spi-ctrl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/merge_outputs.o: ../merge_outputs.c  .generated_files/flags/default/8d31826a0d27aaed613205cd31a44c033123ea13 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../merge_outputs.c  -o ${OBJECTDIR}/_ext/1472/merge_outputs.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/merge_outputs.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/midi_parser.o: ../midi_parser.c  .generated_files/flags/default/7b80bcd86a12d58b5e5ea35388e9a940357f52ea .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../midi_parser.c  -o ${OBJECTDIR}/_ext/1472/midi_parser.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/midi_parser.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/globals.o: ../globals.c  .generated_files/flags/default/9ad7f422cac6e190ef716959576a8f49cfd921ce .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../globals.c  -o ${OBJECTDIR}/_ext/1472/globals.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/globals.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/queue.o: ../queue.c  .generated_files/flags/default/b215e71ab97189e093df708ca9135786cac653b8 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../queue.c  -o ${OBJECTDIR}/_ext/1472/queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/queue.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1832462041/buttons.o: ../usb-bsp/buttons.c  .generated_files/flags/default/3ab7d1e82915282a24dfaa162ff3100aee741607 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/buttons.c  -o ${OBJECTDIR}/_ext/1832462041/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/buttons.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832462041/leds.o: ../usb-bsp/leds.c  .generated_files/flags/default/a8a5f064b20a167d9f35a34bf5b0b333dbb014c4 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/leds.c  -o ${OBJECTDIR}/_ext/1832462041/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832462041/leds.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device.o: ../usb/usb_device.c  .generated_files/flags/default/e409c9154badd92ffdb6fdfd49eb7c93d70fa713 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o: ../usb/usb_device_cdc.c  .generated_files/flags/default/ed00763245269d36196a87ca80b96b86e4630faf .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device_cdc.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o: ../usb/usb_hal_16bit.c  .generated_files/flags/default/e6aa7960b2b433bc2f3bd95c4acd5af78f00fa17 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_hal_16bit.c  -o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o: ../usb-app/app_led_usb_status.c  .generated_files/flags/default/edddf289152a820d5325cc20f5fbd3a9565901b1 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_led_usb_status.c  -o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/system.o: ../usb-app/system.c  .generated_files/flags/default/9b3c55faf8b5f37ed00c12992f2ae8d23508a21d .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/system.c  -o ${OBJECTDIR}/_ext/1832463095/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_descriptors.o: ../usb-app/usb_descriptors.c  .generated_files/flags/default/f351cff72ce68ab52ffe71233710b2c5df57f460 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_descriptors.c  -o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/usb_events.o: ../usb-app/usb_events.c  .generated_files/flags/default/2fef3b1128a7127dcfff40420f18877fcc8d6ce4 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_events.c  -o ${OBJECTDIR}/_ext/1832463095/usb_events.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_events.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o: ../usb-app/app_device_cdc_to_uart.c  .generated_files/flags/default/fdeef1cf27cf68f5676e968ed7ab09acb65d2a86 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_device_cdc_to_uart.c  -o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga.o: ../fpga.c  .generated_files/flags/default/ba4663cc6dd95c932a3aa9d0dab4370c2057b799 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga.c  -o ${OBJECTDIR}/_ext/1472/fpga.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fpga_image.o: ../fpga_image.c  .generated_files/flags/default/a016bf26677f7a7be9b3775bf780a0f90b663bc1 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga_image.c  -o ${OBJECTDIR}/_ext/1472/fpga_image.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fpga_image.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/hal.o: ../hal.c  .generated_files/flags/default/400a229930c4d99c0607fc6a748225f17a46e1e5 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal.c  -o ${OBJECTDIR}/_ext/1472/hal.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/hal.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  .generated_files/flags/default/6fe3a5dc38dbc94c2554bf71df9a76cb2617cfda .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../main.c  -o ${OBJECTDIR}/_ext/1472/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/app.o: ../app.c  .generated_files/flags/default/a1ace2c1f83922d78b3ad56d8fed116102b3dc4a .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../app.c  -o ${OBJECTDIR}/_ext/1472/app.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/app.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/flash.o: ../flash.c  .generated_files/flags/default/6e8a68b1cf7ea47a4ee82e30bdb76330f9c86c8c .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../flash.c  -o ${OBJECTDIR}/_ext/1472/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/flash.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/event-queue.o: ../event-queue.c  .generated_files/flags/default/81111cbe3b802ac1b01d7adce9a2eae74727530c .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../event-queue.c  -o ${OBJECTDIR}/_ext/1472/event-queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/event-queue.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/spi-ctrl.o: ../spi-ctrl.c  .generated_files/flags/default/5ad9f106d3c56e173b721ae7cde85e8d76fd2d8a .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../spi-ctrl.c  -o ${OBJECTDIR}/_ext/1472/spi-ctrl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/merge_outputs.o: ../merge_outputs.c  .generated_files/flags/default/37338ed62b073bf298bc7b22913be8007b0b6f47 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/merge_outputs.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../merge_outputs.c  -o ${OBJECTDIR}/_ext/1472/merge_outputs.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/merge_outputs.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/midi_parser.o: ../midi_parser.c  .generated_files/flags/default/314251d59ebdce578647b6f16ae9fcf85f1e5ee4 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/midi_parser.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../midi_parser.c  -o ${OBJECTDIR}/_ext/1472/midi_parser.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/midi_parser.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/globals.o: ../globals.c  .generated_files/flags/default/c067c006f0921f0d2c36aefc2576ae2c92d0528d .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/globals.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../globals.c  -o ${OBJECTDIR}/_ext/1472/globals.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/globals.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/queue.o: ../queue.c  .generated_files/flags/default/a1309e6def5b2e089c13f354d8d0cf2a50d1d349 .generated_files/flags/default/70652d2c6c28a72ad6785975c7f63c53d012c863
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../queue.c  -o ${OBJECTDIR}/_ext/1472/queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/queue.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
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
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)   -mreserve=data@0x800:0x81B -mreserve=data@0x81C:0x81D -mreserve=data@0x81E:0x81F -mreserve=data@0x820:0x821 -mreserve=data@0x822:0x823 -mreserve=data@0x824:0x827 -mreserve=data@0x82A:0x84F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
