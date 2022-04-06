INVERTER

* 引用库文件，分析及输出配置
.lib "../../PTM-MG/modelfiles/models" ptm10lstp
.inc "./load_circuit.net"

.option acct list post
.global VDD_DESIGN VDD_LOAD VSS
.temp 85.0

.param SUPPLY = 0.75v 
+ LOAD_SIZE = 150

* 电路描述
.subckt inv in out vdd gnd psize=1 nsize=1 
Xpfet out in vdd vdd pfet l=lg nfin=psize
Xnfet out in gnd gnd nfet l=lg nfin=nsize
.ends inv

Xinv_1 in in2 VDD_DESIGN VSS inv psize=1 nsize=1
Xinv_2 in2 in3 VDD_DESIGN VSS inv psize=4 nsize=4
Xinv_3 in3 in4 VDD_DESIGN VSS inv psize=13 nsize=13
Xinv_4 in4 load_in VDD_DESIGN VSS inv psize=47 nsize=47

* 外部激励
VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD VDD_LOAD 0 'SUPPLY'
VVSS VSS 0 0
* 脉冲激励 延时20ns 周期40ns 占空比50%
Vin in VSS pulse 0 'SUPPLY' 20n .01n .01n 20n 40n 

* 电路分析        
.tran 0.001n 200n
.dc Vin 0 'SUPPLY' 0.001

*tplh以及tphl的测量
.measure tran tplh_odd_inv trig v(in) val=0.375 fall=1 targ v(load_in) val=0.375 rise=1 
.measure tran tphl_odd_inv trig v(in) val=0.375 rise=1 targ v(load_in) val=0.375 fall=1 

.measure tran tplh_even_inv trig v(in) val=0.375 rise=1 targ v(load_in) val=0.375 rise=1 
.measure tran tphl_even_inv trig v(in) val=0.375 fall=1 targ v(load_in) val=0.375 fall=1 

* 输出设置
.probe dc v(load_in)
.probe tran v(in) v(load_in)
.end
