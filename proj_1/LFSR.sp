LFSP

* 引用库文件，分析及输出配置
.lib "../PTM-MG/modelfiles/models" ptm7lstp
.inc "./common.net"

.inc "./load_circuit.net"
.inc "./clk_circuit.net"

.inc "./register/24T_TGFF.net"
.inc "./register/24T_CSFF.net"
.inc "./register/26T_SCDFF.net"
.inc "./register/26T_REFF.net"
.inc "./register/26T_TSPC.net"
.inc "./register/18TSPC.net"

.option acct list post probe
.global VDD_DESIGN VDD_CLK VDD_LOAD VSS_COM
.temp 'TEMP'

.param SUPPLY = 0.4v
.param TEMP = 35
.param PERIOD = 20480n
.param CLK_T = 20n


* 电路描述
* 线性移位寄存器
Xff_1  D   Q1      clk_1  VDD_DESIGN VSS_COM scdff
Xff_2  Q1  Q2      clk_2  VDD_DESIGN VSS_COM scdff
Xff_3  Q2  Q3      clk_3  VDD_DESIGN VSS_COM scdff
Xff_4  Q3  Q4      clk_4  VDD_DESIGN VSS_COM scdff
Xff_5  Q4  Q5      clk_5  VDD_DESIGN VSS_COM scdff
Xff_6  Q5  Q6      clk_6  VDD_DESIGN VSS_COM scdff
Xff_7  Q6  Q7      clk_7  VDD_DESIGN VSS_COM scdff
Xff_8  Q7  Q8      clk_8  VDD_DESIGN VSS_COM scdff
Xff_9  Q8  Q9      clk_9  VDD_DESIGN VSS_COM scdff
Xff_10 Q9  Q10     clk_10 VDD_DESIGN VSS_COM scdff
Xff_11 Q10 Q11     clk_11 VDD_DESIGN VSS_COM scdff
Xff_12 Q11 Q12     clk_12 VDD_DESIGN VSS_COM scdff
Xff_13 Q12 Q13     clk_13 VDD_DESIGN VSS_COM scdff
Xff_14 Q13 Q14     clk_14 VDD_DESIGN VSS_COM scdff
Xff_15 Q14 Q15     clk_15 VDD_DESIGN VSS_COM scdff
Xff_16 Q15 load_in clk_16 VDD_DESIGN VSS_COM scdff
* 反馈函数
Xxor_1 load_in Q15  temp_1 VDD_DESIGN VSS_COM xor_tg
Xxor_2 temp_1  Q13  temp_2 VDD_DESIGN VSS_COM xor_tg
Xxor_3 temp_2  Q4   temp_3 VDD_DESIGN VSS_COM xor_tg
Xor2   temp_3  init D      VDD_DESIGN VSS_COM or2




* 外部供电
VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD   VDD_LOAD   0 0.7v
VVDD_CLK    VDD_CLK    0 0.7v
VVSS_COM    VSS_COM    0 0


* 脉冲激励 延时CLK_T*0.5 周期CLK_T 占空比50%
Vclk_in clk_in VSS_COM pulse 0 0.7v 'CLK_T*0.5' .01n .01n 'CLK_T*0.5' 'CLK_T'
Vinit   init   VSS_COM PWL   0 0.7v 'CLK_T*0.75' 0.7v 'CLK_T*0.75+0.01n' 0

* 电路分析

* 基本功能测试        
* .tran 5n 'PERIOD' sweep TEMP 0 70 35

* 工作范围测试
* .tran 1n 'PERIOD' sweep data=mydata
* .data mydata SUPPLY
* + 0.4 
* + 0.38
* + 0.36
* + 0.34
* + 0.32
* + 0.3
* .enddata

* 高能效测试   
.tran 100n 'PERIOD'

* .tran 10n 'PERIOD'

* 测量平均功耗
.measure tran avg_p_VDD_DESIGN AVG p(VVDD_DESIGN) from=0n to='PERIOD'
.measure tran avg_p_VDD_CLK    AVG p(VVDD_CLK)    from=0n to='PERIOD'

* 输出设置
.probe tran v(clk_in)
.probe tran v(init)
.probe tran v(D)
.probe tran v(Q1)
.probe tran v(Q2)
.probe tran v(Q3)
.probe tran v(Q4)
.probe tran v(Q5)
.probe tran v(Q6)
.probe tran v(Q7)
.probe tran v(Q8)
.probe tran v(Q9)
.probe tran v(Q10)
.probe tran v(Q11)
.probe tran v(Q12)
.probe tran v(Q13)
.probe tran v(Q14)
.probe tran v(Q15)
.probe tran v(load_in)

.end