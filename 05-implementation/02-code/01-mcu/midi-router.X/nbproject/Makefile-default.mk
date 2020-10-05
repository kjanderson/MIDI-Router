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
SOURCEFILES_QUOTED_IF_SPACED=../usb-bsp/buttons.c ../usb-bsp/leds.c ../usb/usb_device.c ../usb/usb_device_cdc.c ../usb/usb_hal_16bit.c ../usb-app/app_led_usb_status.c ../usb-app/system.c ../usb-app/usb_descriptors.c ../usb-app/usb_events.c ../usb-app/app_device_cdc_to_uart.c ../fpga.c ../fpga_image.c ../hal.c ../main.c ../app.c ../flash.c ../event-queue.c ../spi-ctrl.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1832462041/buttons.o ${OBJECTDIR}/_ext/1832462041/leds.o ${OBJECTDIR}/_ext/1360939189/usb_device.o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o ${OBJECTDIR}/_ext/1832463095/system.o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o ${OBJECTDIR}/_ext/1832463095/usb_events.o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o ${OBJECTDIR}/_ext/1472/fpga.o ${OBJECTDIR}/_ext/1472/fpga_image.o ${OBJECTDIR}/_ext/1472/hal.o ${OBJECTDIR}/_ext/1472/main.o ${OBJECTDIR}/_ext/1472/app.o ${OBJECTDIR}/_ext/1472/flash.o ${OBJECTDIR}/_ext/1472/event-queue.o ${OBJECTDIR}/_ext/1472/spi-ctrl.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1832462041/buttons.o.d ${OBJECTDIR}/_ext/1832462041/leds.o.d ${OBJECTDIR}/_ext/1360939189/usb_device.o.d ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d ${OBJECTDIR}/_ext/1832463095/system.o.d ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d ${OBJECTDIR}/_ext/1832463095/usb_events.o.d ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d ${OBJECTDIR}/_ext/1472/fpga.o.d ${OBJECTDIR}/_ext/1472/fpga_image.o.d ${OBJECTDIR}/_ext/1472/hal.o.d ${OBJECTDIR}/_ext/1472/main.o.d ${OBJECTDIR}/_ext/1472/app.o.d ${OBJECTDIR}/_ext/1472/flash.o.d ${OBJECTDIR}/_ext/1472/event-queue.o.d ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1832462041/buttons.o ${OBJECTDIR}/_ext/1832462041/leds.o ${OBJECTDIR}/_ext/1360939189/usb_device.o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o ${OBJECTDIR}/_ext/1832463095/system.o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o ${OBJECTDIR}/_ext/1832463095/usb_events.o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o ${OBJECTDIR}/_ext/1472/fpga.o ${OBJECTDIR}/_ext/1472/fpga_image.o ${OBJECTDIR}/_ext/1472/hal.o ${OBJECTDIR}/_ext/1472/main.o ${OBJECTDIR}/_ext/1472/app.o ${OBJECTDIR}/_ext/1472/flash.o ${OBJECTDIR}/_ext/1472/event-queue.o ${OBJECTDIR}/_ext/1472/spi-ctrl.o

# Source Files
SOURCEFILES=../usb-bsp/buttons.c ../usb-bsp/leds.c ../usb/usb_device.c ../usb/usb_device_cdc.c ../usb/usb_hal_16bit.c ../usb-app/app_led_usb_status.c ../usb-app/system.c ../usb-app/usb_descriptors.c ../usb-app/usb_events.c ../usb-app/app_device_cdc_to_uart.c ../fpga.c ../fpga_image.c ../hal.c ../main.c ../app.c ../flash.c ../event-queue.c ../spi-ctrl.c



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
${OBJECTDIR}/_ext/1832462041/buttons.o: ../usb-bsp/buttons.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/buttons.c  -o ${OBJECTDIR}/_ext/1832462041/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832462041/buttons.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832462041/buttons.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832462041/leds.o: ../usb-bsp/leds.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/leds.c  -o ${OBJECTDIR}/_ext/1832462041/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832462041/leds.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832462041/leds.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1360939189/usb_device.o: ../usb/usb_device.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360939189/usb_device.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o: ../usb/usb_device_cdc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device_cdc.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o: ../usb/usb_hal_16bit.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_hal_16bit.c  -o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o: ../usb-app/app_led_usb_status.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_led_usb_status.c  -o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/system.o: ../usb-app/system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/system.c  -o ${OBJECTDIR}/_ext/1832463095/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/system.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/system.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/usb_descriptors.o: ../usb-app/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_descriptors.c  -o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/usb_events.o: ../usb-app/usb_events.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_events.c  -o ${OBJECTDIR}/_ext/1832463095/usb_events.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_events.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/usb_events.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o: ../usb-app/app_device_cdc_to_uart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_device_cdc_to_uart.c  -o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/fpga.o: ../fpga.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga.c  -o ${OBJECTDIR}/_ext/1472/fpga.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/fpga.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/fpga.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/fpga_image.o: ../fpga_image.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga_image.c  -o ${OBJECTDIR}/_ext/1472/fpga_image.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/fpga_image.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/fpga_image.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/hal.o: ../hal.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal.c  -o ${OBJECTDIR}/_ext/1472/hal.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/hal.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/hal.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../main.c  -o ${OBJECTDIR}/_ext/1472/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/main.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/app.o: ../app.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../app.c  -o ${OBJECTDIR}/_ext/1472/app.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/app.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/app.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/flash.o: ../flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../flash.c  -o ${OBJECTDIR}/_ext/1472/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/flash.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/flash.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/event-queue.o: ../event-queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../event-queue.c  -o ${OBJECTDIR}/_ext/1472/event-queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/event-queue.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/event-queue.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/spi-ctrl.o: ../spi-ctrl.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../spi-ctrl.c  -o ${OBJECTDIR}/_ext/1472/spi-ctrl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/_ext/1832462041/buttons.o: ../usb-bsp/buttons.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/buttons.c  -o ${OBJECTDIR}/_ext/1832462041/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832462041/buttons.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832462041/buttons.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832462041/leds.o: ../usb-bsp/leds.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832462041" 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832462041/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-bsp/leds.c  -o ${OBJECTDIR}/_ext/1832462041/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832462041/leds.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832462041/leds.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1360939189/usb_device.o: ../usb/usb_device.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360939189/usb_device.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o: ../usb/usb_device_cdc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_device_cdc.c  -o ${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360939189/usb_device_cdc.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o: ../usb/usb_hal_16bit.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360939189" 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb/usb_hal_16bit.c  -o ${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360939189/usb_hal_16bit.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o: ../usb-app/app_led_usb_status.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_led_usb_status.c  -o ${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/app_led_usb_status.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/system.o: ../usb-app/system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/system.c  -o ${OBJECTDIR}/_ext/1832463095/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/system.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/usb_descriptors.o: ../usb-app/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_descriptors.c  -o ${OBJECTDIR}/_ext/1832463095/usb_descriptors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/usb_descriptors.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/usb_events.o: ../usb-app/usb_events.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/usb_events.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/usb_events.c  -o ${OBJECTDIR}/_ext/1832463095/usb_events.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/usb_events.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/usb_events.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o: ../usb-app/app_device_cdc_to_uart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1832463095" 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../usb-app/app_device_cdc_to_uart.c  -o ${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1832463095/app_device_cdc_to_uart.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/fpga.o: ../fpga.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga.c  -o ${OBJECTDIR}/_ext/1472/fpga.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/fpga.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/fpga.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/fpga_image.o: ../fpga_image.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fpga_image.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fpga_image.c  -o ${OBJECTDIR}/_ext/1472/fpga_image.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/fpga_image.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/fpga_image.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/hal.o: ../hal.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/hal.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal.c  -o ${OBJECTDIR}/_ext/1472/hal.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/hal.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/hal.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../main.c  -o ${OBJECTDIR}/_ext/1472/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/main.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/app.o: ../app.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../app.c  -o ${OBJECTDIR}/_ext/1472/app.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/app.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/app.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/flash.o: ../flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../flash.c  -o ${OBJECTDIR}/_ext/1472/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/flash.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/flash.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/event-queue.o: ../event-queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/event-queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../event-queue.c  -o ${OBJECTDIR}/_ext/1472/event-queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/event-queue.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/event-queue.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1472/spi-ctrl.o: ../spi-ctrl.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/spi-ctrl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../spi-ctrl.c  -o ${OBJECTDIR}/_ext/1472/spi-ctrl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -O0 -I"../" -I"../usb" -I"../usb-app" -I"../usb-bsp" -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/spi-ctrl.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
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
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)   -mreserve=data@0x800:0x81B -mreserve=data@0x81C:0x81D -mreserve=data@0x81E:0x81F -mreserve=data@0x820:0x821 -mreserve=data@0x822:0x823 -mreserve=data@0x824:0x827 -mreserve=data@0x82A:0x84F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST) 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST) 
	${MP_CC_DIR}\\xc16-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/midi-router.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf  
	
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
