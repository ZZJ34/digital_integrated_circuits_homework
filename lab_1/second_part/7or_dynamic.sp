7OR_DYNAMIC

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


Xpfet_clk_1 out_temp clk VDD_DESIGN VDD_DESIGN pfet l=lg nfin=1

Xpfet_clk_2 out_temp load_in VDD_DESIGN VDD_DESIGN pfet l=lg nfin=1

Xnfet_1 out_temp in1_i clk_node VSS nfet l=lg nfin=2
Xnfet_2 out_temp in2_i clk_node VSS nfet l=lg nfin=2
Xnfet_3 out_temp in3_i clk_node VSS nfet l=lg nfin=2
Xnfet_4 out_temp in4_i clk_node VSS nfet l=lg nfin=2
Xnfet_5 out_temp in5_i clk_node VSS nfet l=lg nfin=2
Xnfet_6 out_temp in6_i clk_node VSS nfet l=lg nfin=2
Xnfet_7 out_temp in7_i clk_node VSS nfet l=lg nfin=2

Xnfet_clk clk_node clk VSS VSS nfet l=lg nfin=3

Xinv_output out_temp load_in VDD_DESIGN VSS inv psize=2 nsize=1

VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD VDD_LOAD 0 'SUPPLY'
VVSS VSS 0 0
Vclk clk VSS PWL 0n 0v 15n 0v 15.001n 'SUPPLY' 20n 'SUPPLY' 20.001n 0v 35n 0v 35.001n 'SUPPLY'

.tran 0.0001n 50n

* in1
.alter
Vin1 in1 VSS  PWL 0n 'SUPPLY' 10n 'SUPPLY' 10.001n 0v 30n 0v 30.001n 'SUPPLY'
Vin2 in2 VSS 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(clk) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n
.measure tran avg_clk_power avg p(Vclk) from=0.0001n to=50n

* in1
.alter
Vin1 in1 VSS 'SUPPLY'
Vin2 in2 VSS PWL 0n 'SUPPLY' 10n 'SUPPLY' 10.001n 0v 30n 0v 30.001n 'SUPPLY'
Vin3 in3 VSS 'SUPPLY'
Vin4 in4 VSS 'SUPPLY'
Vin5 in5 VSS 'SUPPLY'
Vin6 in6 VSS 'SUPPLY'
Vin7 in7 VSS 'SUPPLY'
.measure tran tplh trig v(clk) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran avg_power avg p(VVDD_DESIGN) from=0.0001n to=50n
.measure tran avg_clk_power avg p(Vclk) from=0.0001n to=50n

.probe tran
.end
