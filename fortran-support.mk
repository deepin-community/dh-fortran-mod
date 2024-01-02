# Support code that may be used in debian/rules
# Alastair McKinstry <mckinstry@debian.org>
# 2023-12-30

include /usr/share/dpkg/architecture.mk

# WARNING: THIS CODE IS EXPERIMENTAL AND IN HIGH FLUX

# This will set:
#    FC_DEFAULT : the default compiler flavor
#    FC_OPTIONAL : a space seperated list of compiler flavors present except FC_DEFAULT

# FC_DEFAULT is /etc/alternatives/f95 unless FC is specified in the environment

# FC flavors: shortnames for Fortran compilers, currently:
#  gfortran flang flangext lfortran


ifeq ($(origin F77),default)
  F77:=$(shell basename $(shell readlink /etc/alternatives/f77))
endif
ifeq ($(origin FC),environment)
  FC_DEFAULT:=$(FC)
endif
ifeq ($(origin FC),default)
  FC_DEFAULT:=$(shell basename $(shell readlink /etc/alternatives/f95))
endif

FC_COMPILERS:= $(if $(wildcard /usr/bin/gfortran-13), gfortran , ) \
	       $(if $(wildcard /usr/bin/flang-new-17), flang , )  \
	       $(if $(wildcard /usr/bin/flang-to-external-fc-17), flangext , )  \
	       $(if $(wildcard /usr/bin/lfortran), lfortran, )  

FC_OPTIONAL=$(filter-out $(FC_DEFAULT),$(FC_COMPILERS))

# Functions: take flavor as parameter

# get_fmoddir:
#   return the Module(s)directory usable by this flavour

fort_root = /usr/lib/${DEB_HOST_MULTIARCH}/fortran

# Install in this directory
get_fmoddir = $(if $(filter $1,gfortran), ${fort_root}/gfortran-mod-15, \
              $(if $(filter $1, flang), ${fort_root}/flang-mod-15, \
              $(if $(filter $1, flangext), ${fort_root}/flangext-mod-15, \
              $(if $(filter $1, lfortran), ${fort_root}/lfortran-mod-0, \
		                           ${fort_root}/$1 ))))

# Compatible modules for include search. Directories may not be present
get_fmoddirs = $(if $(filter $1,gfortran),  -I${fort_root}/gfortran-mod-15 -I${fort_root}/flangext-mod-15, \
               $(if $(filter $1, flang),    -I${fort_root}/flang-mod-15, \
               $(if $(filter $1, flangext), -I${fort_root}/flangext-mod-15 -I${fort_root}/gfortran-mod-15, \
               $(if $(filter $1, lfortran), -I${fort_root}/lfortran-mod-0, \
		                            -I${fort_root}/$1 ))))

# get_fc_exe
#   Compiler name, suitable for -DCMAKE_Fortran_COMPILER=$(call get_fc_exe,XXX)

get_fc_exe = $(if $(filter $1,gfortran), /usr/bin/gfortran-133, \
             $(if $(filter $1,flang),    /usr/bin/flang-new-17, \
             $(if $(filter $1,flangext), /usr/bin/flang-to-external-fc-17, \
             $(if $(filter $1,lfortran), /usr/bin/lfortran, \
                                         /usr/bin/$(FC_DEFAULT)  ))))

# Inverse of get_fc_exe
#

# TODO  get_fc_flavor = $(if $(filter $(shell $1,/usr/bin//usr/bin/gfortran), gfortran, FALSE)


get_flibdir = "/usr/lib/${DEB_HOST_MULTIARCH}/fortran/$1"

# Compatible directories for library search. Directories may not be present
get_flibdirs = $(if $(filter $1,gfortran), -L${fort_root}/gfortran -L${fort_root}/flangext, \
               $(if $(filter $1,flang),    -L${fort_root}/flang, \
               $(if $(filter $1,flangext), -L${fort_root}/flangext -L${fort_root}/gfortran, \
               $(if $(filter $1,lfortran), -L${fort_root}/lfortran, \
                                           -L${fort_root}/$1 ))))



# Compiler-specific fixes to FCFLAGS

# See #957692
GF10_FLAGS:=$(if $(filter $(shell readlink /usr/bin/gfortran), gfortran-10), \
                 -fallow-invalid-boz -fallow-argument-mismatch, )
FFLAGS=$(shell dpkg-buildflags --get FFLAGS) $(GF10_FLAGS)

FLANG_FCFLAGS:=$(shell dpkg-buildflags --get FCLAGS |  sed -e 's/-mbranch-protection=standard//')

# flang-7 ; no longer needed ?
FLANG_FCFLAGS= $(filter '-g', $(shell dpkg-buildflags --get FCFLAGS))

# Abbreviated names for potentially available Fortran compilers

# Potentially add others if $FC is set (eg ifx, Arm)

# FC_COMPILERS:= gfortran flang-new-17 flang-to-external-fc-17 lfortran
# FC_COMPILERS:= gfortran flang flangext lfortran

