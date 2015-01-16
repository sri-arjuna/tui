Description:
------------

This command for advanced scripting is thought to give you assistance when or if you need to, either: 

* run many, many, lots of many scripts 
* run several scripts to exit successfull, to run another only then



Examples:
---------
Syntax is simple:

	tui-psm /path/to/script1 /path/to/script2 /path/to/script3 ....
	
If you need to make sure a script is only executed if any given number of required scripts are run previously,
you might like the simplicity of this:

Lets say script <name>-6.sh requires the scripts 1-5 to be executed successfully.
Using the **-q** triggers tui-psm to be quiet, so there will be no output at all.
Using the **-c** triggers the exit status to return the number of successfully exited scripts.

	tui-psm -qc *-[1-5].sh
	[[ $? -eq 5 ]] && sh *-6.sh
	

	

More use is to change to the directory containing the scripts and call:

	tui-psm *
	
Which then could look like this:

	# | Paralell Script Manager (0.8)                    2015-01-16 22:30:50 | #
	# |                               Status                                 | #
	# | Running script                     25660                    [  ∞   ] | #
	# | Finished script-0.sh                                        [  √   ] | #
	# | Finished script-1.sh                                        [  √   ] | #
	# | Finished script-2.sh                                        [  √   ] | #
	# | Running script-3.sh                  25764                  [  ∞   ] | #
	# | Finished script-4.sh                                        [  √   ] | #
	# | Running script-5.sh                  26086                  [  ∞   ] | #
	# | Running script-6.sh                  26370                  [  ∞   ] | #
	# | Running script-7.sh                  26396                  [  ∞   ] | #
	# | Running script-8.sh                  26917                  [  ∞   ] | #
	# | Waiting script-9.sh                                         [  ≡   ] | #
	# |                                                                      | #
	# |                               Summary                                | #
	# | Scripts completed:                                              4/11 | #
	# | Currently running:                                               5/5 | #
	# | Successfully executed:                                             4 | #
	# |                                                                      | #
	# | Wait for update...                                             0:0:5 | #