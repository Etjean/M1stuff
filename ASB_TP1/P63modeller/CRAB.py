#!/usr/bin/env python
# Homology modeling by the automodel class
from modeller import *              	# Load standard Modeller classes
from modeller.automodel import *    	# Load the automodel class
log.verbose()    			# request verbose output
env = environ()  			# create a new MODELLER environment to build this model in
# directories for input atom files
#env.io.atom_files_directory = ’./:../atom_files’
env.io.atom_files_directory = './'

a = automodel(env,
              alnfile = 'p63_p53_pir.ali',   # alignment filename
              knowns   = '2ly4',              	# codes of the templates
              sequence = 'CRAB')            # code of the target
a.starting_model= 1                 		# index of the first model
a.ending_model =  1                 		# index of the last model
                                    		# (determines how many models to calculate)
a.make()                            		# do the actual homology modeling
