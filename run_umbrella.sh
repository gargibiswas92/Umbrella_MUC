#!/bin/bash
# $val=6
# do ((i=0; i<23; i++));
#  gmx grompp -f npt_umbrella.mdp -c conf${val}.gro -p topol.top -r conf${val}.gro -n index.ndx -o npt${i}.tpr
#  gmx mdrun -deffnm npt${i} -v
#  $val=$((val+20))
#  done

val=6
for ((i=0; i<23; i++)); do
    gmx grompp -f npt_umbrella.mdp -c conf${val}.gro -p topol.top -r conf${val}.gro -n index.ndx -o npt${i}.tpr -maxwarn 4
    if [ $? -ne 0 ]; then
        echo "Error in grompp for iteration $i"
        exit 1
    fi
    gmx mdrun -deffnm npt${i} -v -ntomp 32 -ntmpi 1 -gpu_id 0
    if [ $? -ne 0 ]; then
        echo "Error in mdrun for iteration $i"
        exit 1
    fi
    val=$((val+20))
done

