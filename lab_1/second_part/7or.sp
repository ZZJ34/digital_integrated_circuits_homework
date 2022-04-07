7OR

* 引用库文件，分析及输出配置
.lib "../../PTM-MG/modelfiles/models" ptm10lstp
.inc "./load_circuit.net"

.option acct list post
.global VDD_DESIGN VDD_LOAD VSS
.temp 85.0

.param SUPPLY = 0.75v
+ LOAD_SIZE = 32

* 电路描述
.subckt inv in out vdd gnd psize=1 nsize=1 
Xpfet out in vdd vdd pfet l=lg nfin=psize
Xnfet out in gnd gnd nfet l=lg nfin=nsize
.ends inv

Xinv_input_1 in1 in1_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_2 in2 in2_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_3 in3 in3_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_4 in4 in4_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_5 in5 in5_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_6 in6 in6_i VDD_LOAD VSS inv psize=1 nsize=1
Xinv_input_7 in7 in7_i VDD_LOAD VSS inv psize=1 nsize=1

Xpfet_1 out_temp in1_i p_node_1 VDD_DESIGN pfet l=lg nfin=7
Xpfet_2 p_node_1 in2_i p_node_2 VDD_DESIGN pfet l=lg nfin=7
Xpfet_3 p_node_2 in3_i p_node_3 VDD_DESIGN pfet l=lg nfin=7
Xpfet_4 p_node_3 in4_i p_node_4 VDD_DESIGN pfet l=lg nfin=7
Xpfet_5 p_node_4 in5_i p_node_5 VDD_DESIGN pfet l=lg nfin=7
Xpfet_6 p_node_5 in6_i p_node_6 VDD_DESIGN pfet l=lg nfin=7
Xpfet_7 p_node_6 in7_i VDD_DESIGN VDD_DESIGN pfet l=lg nfin=7

Xnfet_1 out_temp in1_i VSS VSS nfet l=lg nfin=1
Xnfet_2 out_temp in2_i VSS VSS nfet l=lg nfin=1
Xnfet_3 out_temp in3_i VSS VSS nfet l=lg nfin=1
Xnfet_4 out_temp in4_i VSS VSS nfet l=lg nfin=1
Xnfet_5 out_temp in5_i VSS VSS nfet l=lg nfin=1
Xnfet_6 out_temp in6_i VSS VSS nfet l=lg nfin=1
Xnfet_7 out_temp in7_i VSS VSS nfet l=lg nfin=1

Xinv_output_1 out_temp load_in VDD_DESIGN VSS inv psize=6 nsize=6

* 设置外部激励
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