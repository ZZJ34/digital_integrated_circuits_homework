EDP

* 引用库文件，分析及输出配置
.lib "../../PTM-MG/modelfiles/models" ptm10lstp
.inc "./load_circuit.net"

.option acct list post
.global VDD_DESIGN VDD_LOAD VSS
.temp 85.0

.param SUPPLY = 0.75v 
+ LOAD_SIZE = 150
+ STEP = -0.001v

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
* 脉冲激励 延时50ns 周期100ns 占空比50%
Vin in VSS pulse 0 'SUPPLY' 50n .01n .01n 50n 100n 

* 电路分析        
.tran 0.001n 800n sweep SUPPLY 0.69 0.67 'STEP'

*tplh以及tphl的测量
.measure tran tplh trig v(in) val='SUPPLY/2' rise=1 targ v(load_in) val='SUPPLY/2' rise=1 
.measure tran tphl trig v(in) val='SUPPLY/2' fall=1 targ v(load_in) val='SUPPLY/2' fall=1
.measure tran avg_power_Xinv_1 avg p(Xinv_1) from=1n to=800n
.measure tran avg_power_Xinv_2 avg p(Xinv_2) from=1n to=800n
.measure tran avg_power_Xinv_3 avg p(Xinv_3) from=1n to=800n
.measure tran avg_power_Xinv_4 avg p(Xinv_4) from=1n to=800n  

* 输出设置
.probe tran v(in) v(load_in)
.end
