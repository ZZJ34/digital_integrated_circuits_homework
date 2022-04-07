7OR_HIER_RESIZE

* 引用库文件，分析及输出配置
.lib "../../PTM-MG/modelfiles/models" ptm10lstp
.inc "./load_circuit.net"

.option acct list post
.global VDD_DESIGN VDD_LOAD VSS
.temp 85.0

.param SUPPLY = 0.75v
+ LOAD_SIZE = 32

* 电路描述
* 可定义尺寸的反相器
.subckt inv in out vdd gnd psize=1 nsize=1 
Xpfet out in vdd vdd pfet l=lg nfin=psize
Xnfet out in gnd gnd nfet l=lg nfin=nsize
.ends inv

* 两输入或非门
.subckt nor2 in1 in2 out vdd gnd 
Xpfet_1 out in1 p_node_1 vdd pfet l=lg nfin=2
Xpfet_2 p_node_1 in2 vdd vdd pfet l=lg nfin=2
Xnfet_1 out in1 gnd gnd nfet l=lg nfin=1
Xnfet_2 out in2 gnd gnd nfet l=lg nfin=1
.ends nor2

* 三输入或非门
.subckt nor3 in1 in2 in3 out vdd gnd 
Xpfet_1 out in1 p_node_1 vdd pfet l=lg nfin=3
Xpfet_2 p_node_1 in2 p_node_2 vdd pfet l=lg nfin=3
Xpfet_3 p_node_2 in3 vdd vdd pfet l=lg nfin=3
Xnfet_1 out in1 gnd gnd nfet l=lg nfin=1
Xnfet_2 out in2 gnd gnd nfet l=lg nfin=1
Xnfet_3 out in3 gnd gnd nfet l=lg nfin=1
.ends nor3

* 输入负载
Xinv_input_1 in1 in1_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_2 in2 in2_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_3 in3 in3_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_4 in4 in4_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_5 in5 in5_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_6 in6 in6_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_7 in7 in7_i VDD_LOAD VSS inv psize=1 nsize=1

* 一级与非门
Xnor2_1 in1_i in2_i out_1 VDD_DESIGN VSS nor2
Xnor2_2 in3_i in4_i out_2 VDD_DESIGN VSS nor2
Xnor3_3 in5_i in6_i in7_i out_3 VDD_DESIGN VSS nor3

Xinv_out_1 out_1 out_1_i VDD_DESIGN VSS inv psize=1 nsize=1
Xinv_out_2 out_2 out_2_i VDD_DESIGN VSS inv psize=1 nsize=1
Xinv_out_3 out_3 out_3_i VDD_DESIGN VSS inv psize=1 nsize=1

* 二级与非门
Xnor3_4 out_1_i out_2_i out_3_i out_temp VDD_DESIGN VSS nor3

Xinv_out_4 out_temp load_in VDD_DESIGN VSS inv psize=4 nsize=3


VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD VDD_LOAD 0 'SUPPLY'
VVSS VSS 0 0

.tran 0.0001n 50n

* in1
.alter
Vin1 in1 VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n 
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(in1) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in1) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n

* in2
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(in2) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in2) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n

* in3
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(in3) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in3) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n

* in4
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(in4) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in4) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n

* in5
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(in5) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in5) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n

* in6
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS  pulse 0 'SUPPLY' 20n .01n .01n 20n 40n
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(in6) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in6) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n

* in7
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY' 
Vin7 in7 VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n
.measure tran tplh trig v(in7) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in7) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n


.probe tran

.end