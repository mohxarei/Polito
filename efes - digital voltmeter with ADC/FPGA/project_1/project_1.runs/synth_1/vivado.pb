
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:052

00:00:102	
530.2892	
201.199Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental {X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/project_1/project_1.srcs/utils_1/imports/synth_1/my_project.dcp}Z12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2�
�X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/project_1/project_1.srcs/utils_1/imports/synth_1/my_project.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
e
Command: %s
53*	vivadotcl24
2synth_design -top my_project -part xc7z020clg400-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
z
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7z020Z17-347h px� 
j
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7z020Z17-349h px� 
�
^The reference checkpoint is from an old version of Vivado; A full resynthesis flow will be run653*	vivadotclZ4-1809h px� 
D
Loading part %s157*device2
xc7z020clg400-1Z21-403h px� 
Z
$Part: %s does not have CEAM library.966*device2
xc7z020clg400-1Z21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
11164Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:08 . Memory (MB): peak = 1416.914 ; gain = 449.059
h px� 
�
synthesizing module '%s'638*oasys2

my_project2c
_X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/my_project.vhd2
258@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

SPI_Master2]
[X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Master.vhd2
52
master_uint2

SPI_Master2c
_X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/my_project.vhd2
698@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2

SPI_Master2_
[X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Master.vhd2
168@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

SPI_Master2
02
12_
[X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Master.vhd2
168@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2	
ADC08312^
\X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/ADC0831.vhd2
42

ADC_uint2	
ADC08312c
_X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/my_project.vhd2
728@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2	
ADC08312`
\X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/ADC0831.vhd2
178@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2	
ADC08312
02
12`
\X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/ADC0831.vhd2
178@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

my_project2
02
12c
_X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/my_project.vhd2
258@Z8-256h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:10 . Memory (MB): peak = 1530.688 ; gain = 562.832
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:04 ; elapsed = 00:00:11 . Memory (MB): peak = 1530.688 ; gain = 562.832
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:04 ; elapsed = 00:00:11 . Memory (MB): peak = 1530.688 ; gain = 562.832
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0122

1530.6882
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc8Z20-179h px� 
�
No ports matched '%s'.
584*	planAhead2	
Ref_clk2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
18@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
18@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2	
Ref_clk2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
28@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
28@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
PB12]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
208@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
208@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
LED2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
218@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
218@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
LED2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
228@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
228@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
PB12]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
258@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
258@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
LED12]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
368@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
368@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
LED22]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
378@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
378@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
LED12]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
388@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
388@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
LED22]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
398@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
398@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
PB22]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
408@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
408@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
PB22]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
418@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
418@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_cs2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
558@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
558@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_cs2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
568@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
568@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2	
spi_clk2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
578@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
578@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2	
spi_clk2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
588@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
588@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

spi_miso2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
598@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
598@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

spi_miso2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
608@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
608@Z17-55h px�
�
Finished Parsing XDC File [%s]
178*designutils2]
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2[
YX:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/Pins.xdc2
.Xil/my_project_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1640.5082
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0032

1640.5082
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:09 ; elapsed = 00:00:21 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7z020clg400-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:09 ; elapsed = 00:00:21 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:09 ; elapsed = 00:00:21 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
v
3inferred FSM for state register '%s' in module '%s'802*oasys2
current_state_reg2

SPI_MasterZ8-802h px� 
i
3inferred FSM for state register '%s' in module '%s'802*oasys2	
FSM_reg2	
ADC0831Z8-802h px� 
n
3inferred FSM for state register '%s' in module '%s'802*oasys2
	write_reg2

my_projectZ8-802h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                    idle |                             0001 |                               00
h p
x
� 
y
%s
*synth2a
_                    load |                             0010 |                               01
h p
x
� 
y
%s
*synth2a
_                    send |                             0100 |                               10
h p
x
� 
y
%s
*synth2a
_                complete |                             1000 |                               11
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
current_state_reg2	
one-hot2

SPI_MasterZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                    idle |                              000 |                              000
h p
x
� 
y
%s
*synth2a
_                  tsetup |                              001 |                              001
h p
x
� 
y
%s
*synth2a
_                   read1 |                              010 |                              010
h p
x
� 
y
%s
*synth2a
_                   read2 |                              011 |                              011
h p
x
� 
y
%s
*synth2a
_                    stop |                              100 |                              100
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                              101 |                              111
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2	
FSM_reg2

sequential2	
ADC0831Z8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                               00 |                               11
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                               01 |                               00
h p
x
� 
y
%s
*synth2a
_                 iSTATE1 |                               10 |                               01
h p
x
� 

%s
*synth2
*
h p
x
� 
y
%s
*synth2a
_                 iSTATE2 |                               11 |                               10
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	write_reg2

sequential2

my_projectZ8-3354h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:23 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 2     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               32 Bit    Registers := 6     
h p
x
� 
H
%s
*synth20
.	                9 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                2 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 12    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   6 Input    9 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   4 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   6 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   5 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   3 Input    2 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 5     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 22    
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 10    
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   6 Input    1 Bit        Muxes := 8     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
%s
*synth2Y
WPart Resources:
DSPs: 220 (col length:60)
BRAMs: 280 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:12 ; elapsed = 00:00:28 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:17 ; elapsed = 00:00:37 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:17 ; elapsed = 00:00:37 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:17 ; elapsed = 00:00:37 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|      |Cell   |Count |
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|1     |BUFG   |     1|
h px� 
2
%s*synth2
|2     |CARRY4 |    48|
h px� 
2
%s*synth2
|3     |LUT1   |     3|
h px� 
2
%s*synth2
|4     |LUT2   |    24|
h px� 
2
%s*synth2
|5     |LUT3   |    17|
h px� 
2
%s*synth2
|6     |LUT4   |    44|
h px� 
2
%s*synth2
|7     |LUT5   |    43|
h px� 
2
%s*synth2
|8     |LUT6   |    48|
h px� 
2
%s*synth2
|9     |FDRE   |   275|
h px� 
2
%s*synth2
|10    |FDSE   |     6|
h px� 
2
%s*synth2
|11    |IBUF   |     4|
h px� 
2
%s*synth2
|12    |IOBUF  |     8|
h px� 
2
%s*synth2
|13    |OBUF   |    15|
h px� 
2
%s*synth2
+------+-------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:15 ; elapsed = 00:00:41 . Memory (MB): peak = 1640.508 ; gain = 562.832
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:20 ; elapsed = 00:00:44 . Memory (MB): peak = 1640.508 ; gain = 672.652
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0072

1640.5082
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
56Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1640.5082
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2Y
W  A total of 8 instances were transformed.
  IOBUF => IOBUF (IBUF, OBUFT): 8 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

1c0e0a2cZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
362
202
182
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:252

00:00:522

1640.5082

1103.457Z17-268h px� 
c
%s6*runtcl2G
ESynthesis results are not added to the cache due to CRITICAL_WARNING
h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0032

1640.5082
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2�
�X:/1 Learning/1 Polito Master/2 Elec Course/report/datasheets + code/vhdl/mohsen/project_1/project_1.runs/synth_1/my_project.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2_
]report_utilization -file my_project_utilization_synth.rpt -pb my_project_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Thu Dec 12 13:54:22 2024Z17-206h px� 


End Record