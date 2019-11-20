VSRC = timescale.sv definitions.sv utopia.sv cpu_ifc.sv top.sv  
ISRC = LookupTable.sv utopia1_atm_rx.sv utopia1_atm_tx.sv squat.sv
SSRC = virtual_interfaces.sv atm_cell.sv config.sv generator.sv driver.sv monitor.sv scoreboard.sv coverage.sv cpu_driver.sv environment.sv test.sv 
VOPTS =  -sverilog -debug_all +libext+.sv -y . -cm line+tgl -kdb -licqueue +vcs+flush+all '+warn=all' -CFLAGS -DVCS -kdb -lca
SOPT = +ntb_solver_mode=1 -l simv.log -cm line+tgl +vcs+lic+wait


VERDIOPT = -ssy -ssv -nologo -L work_top -simflow -simBin simv -logdir verdiLog -tkName verdi_tkName_`whoami`_`date +%Y_%m_%d_%H_%M_%S`

cov:	simv.vdb
	urg -dir simv.vdb
	urg -dir simv.vdb -format text

dve:	simv.vdb
	dve -lca -cov -covdir simv.cm

run simv.vdb:	simv
#	./simv ${SOPT} +ntb_random_seed=19
	./simv ${SOPT} +ntb_random_seed_automatic

simv:   ${VSRC} ${SSRC} ${ISRC}
	vcs ${VOPTS} -l comp.log ${VSRC} ${ISRC} ${SSRC} 


wave:
	verdi -f ${VSRC} ${ISRC} ${SSRC} ${VERDIOPT} -ssf dump.fsdb


DIR = $(shell basename `pwd`)
tar:	clean
	cd ..; tar cvfz utopia.tgz ${DIR}

clean:
	@rm -rf *~ *.log *.vpd vc_hdrs.h .vcsmx_rebuild DVEfiles .nfs* .restartSimSession*
	@rm -rf simv* csrc* core* *.vrh *shell.v .__solver* *.key .ucli* .nfs* *.tcl urgReport
