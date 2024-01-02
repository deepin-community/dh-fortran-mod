# Quick test code. Not part of a build

include ./fortran-support.mk

all:
	@echo FC_DEFAULT $(FC_DEFAULT) FC_OPTIONAL $(FC_OPTIONAL)
	@echo
	@echo "get_fmoddir,default-> "  $(call get_fmoddir,$(FC_DEFAULT))
	@echo "get_fmoddir,gfortran -> "  $(call get_fmoddir,gfortran)
	@echo "get_fmoddir,flang -> "  $(call get_fmoddir,flang)
	@echo "get_fmoddir,flangext-> "  $(call get_fmoddir,flangext)
	@echo "get_fmoddir,lfortran-> "  $(call get_fmoddir,lfortran)
	@echo
	@echo "get_fmoddirs,default-> "  $(call get_fmoddirs,$(FC_DEFAULT))
	@echo "get_fmoddirs,gfortran -> "  $(call get_fmoddirs,gfortran)
	@echo "get_fmoddirs,flang -> "  $(call get_fmoddirs,flang)
	@echo "get_fmoddirs,flangext-> "  $(call get_fmoddirs,flangext)
	@echo "get_fmoddirs,lfortran-> "  $(call get_fmoddirs,lfortran)
	@echo
	@echo "get_flibdir,default-> "  $(call get_flibdir,$(FC_DEFAULT))
	@echo "get_flibdir,gfortran -> "  $(call get_flibdir,gfortran)
	@echo "get_flibdir,flang -> "  $(call get_flibdir,flang)
	@echo "get_flibdir,flangext-> "  $(call get_flibdir,flangext)
	@echo "get_flibdir,lfortran-> "  $(call get_flibdir,lfortran)
	@echo
	@echo "get_flibdirs,default-> "  $(call get_flibdirs,$(FC_DEFAULT))
	@echo "get_flibdirs,gfortran -> "  $(call get_flibdirs,gfortran)
	@echo "get_flibdirs,flang -> "  $(call get_flibdirs,flang)
	@echo "get_flibdirs,flangext-> "  $(call get_flibdirs,flangext)
	@echo "get_flibdirs,lfortran-> "  $(call get_flibdirs,lfortran)
	@echo
	@echo "get_fc_exe,default-> "  $(call get_fc_exe,default)
	@echo "get_fc_exe,gfortran -> "  $(call get_fc_exe,gfortran)
	@echo "get_fc_exe,flang -> "  $(call get_fc_exe,flang)
	@echo "get_fc_exe,flangext-> "  $(call get_fc_exe,flangext)
	@echo "get_fc_exe,lfortran-> "  $(call get_fc_exe,lfortran)
