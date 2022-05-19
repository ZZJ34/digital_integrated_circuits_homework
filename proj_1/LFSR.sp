LFSP

* 引用库文件，分析及输出配置
.lib "../PTM-MG/modelfiles/models" ptm10lstp
.inc "./load_circuit.net"
.inc "./clk_circuit.net"

.option acct list post
.global VDD_DESIGN VDD_CLK VDD_LOAD VSS
.temp 35.0

.param SUPPLY = 0.75v 


* 电路描述
* 时钟节点 clk_x x from 1 to 16
* 负载节点 load_in


* 外部供电
VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD   VDD_LOAD   0 'SUPPLY'
VVDD_CLK    VDD_CLK    0 'SUPPLY'
VVSS        VSS        0 0


* 脉冲激励 延时20ns 周期40ns 占空比50%
Vclk_in clk_in VSS pulse 0 'SUPPLY' 30n .01n .01n 30n 60n


* 电路分析        
.tran 0.001n 500n

* 输出设置
.probe tran
.end