#!/bin/python

out1 = open('tpr_files.dat', 'w')
out2 = open('pullf_files.dat', 'w')

for i in range(0,22):
 ss1 = ['umbrella'+str(i)+'.tpr','\n']
 ss2 = ['umbrella'+str(i)+'_pullf.xvg', '\n']
 out1.writelines(ss1)
 out2.writelines(ss2)
 
out1.close()
out2.close()