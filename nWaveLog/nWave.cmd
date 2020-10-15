wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvConvertFile -win $_nWave1 -o \
           "/home/team02/lab2/src/tb_verilog/wrapper.fsdb.fsdb" \
           "/home/team02/lab2/src/tb_verilog/wrapper.fsdb"
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/team02/lab2/src/tb_verilog/wrapper.fsdb.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvGetSignalOpen -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvConvertFile -win $_nWave1 -o \
           "/home/team02/lab2/src/tb_verilog/wrapper.fsdb.fsdb" \
           "/home/team02/lab2/src/tb_verilog/wrapper.fsdb"
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
{/PPForwardLoopIn/clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
{/PPForwardLoopIn/clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
{/PPForwardLoopIn/clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvCloseFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvTpfCloseForm -win $_nWave1
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/team02/lab2/src/tb_verilog/wrapper.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvGetSignalClose -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb"
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
{/tb/avm_ack} \
{/tb/avm_actually_read} \
{/tb/avm_actually_write} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_clk} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 3 4 5 6 7 8 9 10 )} 
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PPForwardLoopIn/clk} \
{/tb/avm_ack} \
{/tb/avm_actually_read} \
{/tb/avm_actually_write} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_clk} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 3 4 5 6 7 8 9 10 )} 
wvSetPosition -win $_nWave1 {("G1" 10)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 \
           "/tb/Unnamed_\$test_wrapper_sv_196/Unnamed_\$test_wrapper_sv_199"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_input"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/avm_ack} \
{/tb/avm_actually_read} \
{/tb/avm_actually_write} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_clk} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/avm_ack} \
{/tb/avm_actually_read} \
{/tb/avm_actually_write} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_clk} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetPosition -win $_nWave1 {("G1" 10)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetCursor -win $_nWave1 5437.924393 -snap {("G1" 10)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_pp_rnd_from232"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/StartWrite"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/avm_ack} \
{/tb/avm_actually_read} \
{/tb/avm_actually_write} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_clk} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/avm_clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/avm_ack} \
{/tb/avm_actually_read} \
{/tb/avm_actually_write} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_clk} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/avm_clk} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvSetCursor -win $_nWave1 5442.831666 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 5456.555397 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 5463.625198 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 5470.694999 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 7336.560973 -snap {("G1" 7)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectGroup -win $_nWave1 {G2}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 7125.860117 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvExpandBus -win $_nWave1 {("G1" 8)}
wvScrollUp -win $_nWave1 12
wvScrollUp -win $_nWave1 209
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvCollapseBus -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/enc_w\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/enc_w\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/enc_w\[255:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/enc_w\[255:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalClose -win $_nWave1
wvSelectGroup -win $_nWave1 {G2}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvResizeWindow -win $_nWave1 2847 404 960 332
wvResizeWindow -win $_nWave1 2600 404 1207 332
wvResizeWindow -win $_nWave1 2600 142 1207 594
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core/rsa_mont_0"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/enc_w\[255:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_rdy} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/enc_w\[255:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvExpandBus -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvCollapseBus -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetPosition -win $_nWave1 {("G1" 5)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 10)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 2)}
wvZoom -win $_nWave1 905418.710653 978557.399988
wvZoom -win $_nWave1 934867.002584 945252.784113
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 1545758.908538 1658217.830557
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSelectGroup -win $_nWave1 {G3}
wvMoveSelected -win $_nWave1
wvSetMarker -win $_nWave1 1610377.306511
wvSetCursor -win $_nWave1 1609164.448155 -snap {("G3" 0)}
wvSetCursor -win $_nWave1 1601819.916998 -snap {("G3" 0)}
wvSelectGroup -win $_nWave1 {G3}
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectGroup -win $_nWave1 {G3}
wvMoveSelected -win $_nWave1
wvSetMarker -win $_nWave1 1545758.908538
wvMoveSelected -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 2233742.902067 2330766.285770
wvZoom -win $_nWave1 2271936.049516 2288445.720560
wvZoom -win $_nWave1 2277346.948294 2284093.260848
wvSetCursor -win $_nWave1 2279376.096827 -snap {("G3" 0)}
wvSetCursor -win $_nWave1 2281902.427172 -snap {("G3" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 2 )} 
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 2 )} 
wvSetPosition -win $_nWave1 {("G3" 2)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
{/tb/u_master/rsa256_core/state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
{/tb/u_master/rsa256_core/state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvGetSignalClose -win $_nWave1
wvZoom -win $_nWave1 879825.684032 987874.452247
wvZoom -win $_nWave1 936277.766646 940485.777392
wvZoom -win $_nWave1 938730.968836 938884.766713
wvSetCursor -win $_nWave1 938825.975194 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 938834.268668 -snap {("G3" 3)}
wvSetCursor -win $_nWave1 938826.804541 -snap {("G4" 0)}
wvSetCursor -win $_nWave1 938825.514445 -snap {("G3" 3)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
{/tb/u_master/rsa256_core/state\[1:0\]} \
{/tb/u_master/rsa256_core/counter\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
{/tb/u_master/rsa256_core/state\[1:0\]} \
{/tb/u_master/rsa256_core/counter\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSetPosition -win $_nWave1 {("G3" 4)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetCursor -win $_nWave1 938809.388245 -snap {("G4" 0)}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PPForwardLoopIn"
wvGetSignalSetScope -win $_nWave1 "/tb"
wvGetSignalSetScope -win $_nWave1 "/tb/Unnamed_\$test_wrapper_sv_196"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvSetCursor -win $_nWave1 938807.268801 -snap {("G4" 0)}
wvSetCursor -win $_nWave1 938852.053564 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 938803.214214 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb/u_master/rsa256_core"
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
{/tb/u_master/rsa256_core/counter\[8:0\]} \
{/tb/u_master/rsa256_core/state\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb/u_master/avm_clk} \
{/tb/avm_address\[4:0\]} \
{/tb/avm_read} \
{/tb/avm_readdata\[31:0\]} \
{/tb/u_master/avm_writedata\[31:0\]} \
{/tb/avm_rst_n} \
{/tb/u_master/state_r\[2:0\]} \
{/tb/u_master/d_r\[255:0\]} \
{/tb/u_master/n_r\[255:0\]} \
{/tb/u_master/enc_r\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/tb/u_master/rsa_finished} \
{/tb/u_master/rsa_dec\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/tb/u_master/rsa256_core/i_start} \
{/tb/u_master/rsa256_core/o_finished} \
{/tb/u_master/rsa256_core/counter\[8:0\]} \
{/tb/u_master/rsa256_core/state\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSetPosition -win $_nWave1 {("G3" 4)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 938825.883044 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 938834.360818 -snap {("G3" 4)}
wvExit
